require 'formula'

class ModProxyHtml < Formula
  homepage 'http://apache.webthing.com/mod_proxy_html/'
  url 'http://apache.webthing.com/mod_proxy_html/mod_proxy_html.tar.bz2'
  sha1 'cd31a2af413e9e3315db617880659d5e93aaf09f'
  head 'http://apache.webthing.com/svn/apache/filters/proxy_html/'

  depends_on 'libxml2'

  def install
    system "apxs -c -I#{Formula.factory('libxml2').prefix}/include/libxml2/ mod_xml2enc.c"
    system "apxs -c -I#{Formula.factory('libxml2').prefix}/include/libxml2/ -I./ mod_proxy_html.c"
    libexec.install '.libs/mod_xml2enc.so'
    libexec.install '.libs/mod_proxy_html.so'
    prefix.install 'proxy_html.conf'
  end

  def caveats; <<-EOS.undent
    You must manually edit /etc/apache2/httpd.conf to contain:
    LoadFile	#{Formula.factory('libxml2').prefix}/lib/libxml2.dylib
    LoadModule	proxy_html_module	#{libexec}/mod_proxy_html.so
    LoadModule	xml2enc_module		#{libexec}/mod_xml2enc.so
    Include #{prefix}/proxy_html.conf
    EOS
  end

end
