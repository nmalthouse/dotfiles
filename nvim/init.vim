let mapleader = " "
let maplocalleader = " "
syntax on

"keep 4 lines of padding
set scrolloff=4

"Write to window title"
set title 

" do case insesitive search when query is all lowercase
set ignorecase
set smartcase 

fun! ZigFileFunc()
    ia COMPUN       @compileError("unsupported " ++ <++>)<++>
    ia FMT          pub fn format(value: @This(), comptime fmt: []const u8, options: std.fmt.FormatOptions, writer:anytype)!void{<++>}
    ia IMP          const <++> = @import("<++>");
    ia HASHMAP      std.AutoHashMap(<++>, <++>)
    ia DALLOC       var gpa = std.heap.GeneralPurposeAllocator(.{}){};<CR>defer _ = gpa.detectLeaks();<CR>const alloc = gpa.allocator();
    ia DC           pub const c = @cImport({@cInclude(<++>);});
    ia OPENFILE     const cwd = try std.fs.cwd();<CR>const <++> = cwd.openFile(<++>, .{<++>});
    ia INIT         pub fn init(<++>)Self {}<CR><CR>pub fn deinit(self: *Self)void{}
    ia FBS          std.io.FixedBufferStream([]const u8);
    " ia DFBS         const fbs_buffer: [<++>]u8 = undefined;<CR>var fbs = std.io.FixedBufferStream([]u8)
    ia TT           <++>
    ia EU           <++>
    ia STRUCT       const <++> = struct {<CR><CR>};
    ia PSTRUCT      pub const <++> = struct {<CR><CR>};
    ia PRINT        std.debug.print("<++>\n",.{});
    ia PRINTN       std.debug.print("<++>: {d}\n", .{<++>});
    ia PRINTS       std.debug.print("<++>: {s}", .{<++>});
    ia PRINTANY     std.debug.print("<++>: {any}\n", .{<++>});
    ia FN           fn <++>(<++>)<++> {<CR><++><CR>}
    ia PFN          pub fn <++>(<++>)<++> {<CR><++><CR>}
    ia DDESTROY     defer <++>.deinit();
    ia DEINIT      <++>.deinit();
    ia DSELF        const Self = @This();
    ia SELF         self: *Self,
    ia STD          const std = @import("std");
    ia ALLOC        alloc: std.mem.Allocator,
    ia SWITCH       switch(<++>){<CR><++> => {<++>},<CR>=> else{<++>},<CR>}
    ia FORIR        {var i:usize = 0; <CR>while(i < <++>): (i += 1) {<CR><CR>}}
    ia ORU          orelse unreachable
    ia IFNULL       if(<++>) \|<++>\|{<CR><++><CR>}
    ia TEST         test "<++>"{<CR><++><CR>}
    ia CATCH        catch \|err\| {<CR><++><CR>}
    ia VEC          std.ArrayList(<++>)
    ia VECINIT      std.ArrayList(<++>).init(alloc)
    ia FOR          for(<++>) \|<++>, <++> \|{<CR><++><CR>}
    ia WHILE        {<CR>var <++>: usize = 0;<CR>while(<++>) : (<++>) {}}


    " Replace Function
    
    " Wrap word in zig cast function
    map <Leader>itf ysiwf@intToFloat<CR>f(li<++>,
    map <Leader>fti ysiwf@floatToInt<CR>f(li<++>,
    map <Leader>ite ysiwf@intToEnum<CR>f(li<++>,
    map <Leader>ptc ysiwf@ptrCast<CR>f(li<++>,
    map <Leader>df ysifwf@divFloor<CR>f(li<++>,

    map <leader>r :!zig build run <CR>
    map <leader>t :!zig test "%"<CR>

    " Set custom args with let zigargs = 'arg1 arg2'
    map <leader>c :execute "!zig build run --" zigargs <CR> "

    command! Source source ~/.config/nvim/init.vim

    

    "set path+=/usr/lib/zig/std/
    
    "set include = require()
endfun
autocmd FileType zig call ZigFileFunc()

fun! JavaFileFunc()
    ia JBEGIN       public class <++> {<CR>public static void main(String[] args){<++>}<CR>}
    ia PRINT        System.out.println("<++>");

    map <leader>r :execute "!javac % && java" expand('%:t:r') <CR>
endfun
autocmd FileType java call JavaFileFunc()

autocmd FileType json :%!jq .


map <leader>n :execute runarg <CR>

set omnifunc=syntaxcomplete$Complete

" map <Leader>r :make <CR>

fun! CFileFunc()
    ia cerr std::cerr << "" << std::endl;
    ia #i #include
    ia FF for(int i = 0; i < <++>; i++){<CR>}
    ia #d #define

    map <leader>r :!make <CR>
endfun
autocmd FileType c,cpp,h,hpp call CFileFunc()



map <Leader>func ysiwf 

inoremap <c-u> <Esc>/<++><CR><Esc>cf>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" FZF file browser
map <C-a> :Files <CR>
map <C-n> :FZF /usr/lib/zig/std <CR>

command! Config e ~/.config/nvim/init.vim

set hlsearch

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

map <Leader><c-E> :FZF<CR>

vnoremap <leader>y "+y 
nnoremap <leader>yy "+yy

nnoremap <c-s> :w <CR>
imap eu <Esc>

if empty(glob(stdpath('data') .. '/plugged'))
    silent! execute '!curl --create-dirs -fsSlo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * silent! PlugInstall
endif


call plug#begin()
    Plug 'itchyny/lightline.vim' " the line at the bottom
    Plug 'tpope/vim-surround' "Change pairs like '' [] in one go
    Plug 'raimondi/delimitmate' "Auto add  ' '
    Plug 'justinmk/vim-sneak' " the s key like f and t
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'sainnhe/everforest'
    
    Plug 'ziglang/zig.vim'
    Plug 'nvim-lua/completion-nvim'
    
call plug#end()

autocmd CompleteDone * silent! pclose!

set foldmethod=syntax
set nofoldenable
set foldlevel=19

if has('termguicolors')
      set termguicolors
endif
set background=dark

let g:everforest_background = 'medium'
let g:everforest_disable_terminal_colors = 1
let g:everforest_colors_override = {'bg0': ['0xffffff', '255']}

colorscheme everforest
