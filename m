Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4D5B4699
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIJOXG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJOXF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 10:23:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54B934DF21;
        Sat, 10 Sep 2022 07:23:02 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [114.216.208.34] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Sat, 10 Sep 2022 22:21:53
 +0800 (GMT+08:00)
X-Originating-IP: [114.216.208.34]
Date:   Sat, 10 Sep 2022 22:21:53 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Ard Biesheuvel" <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Matthew Garrett" <mjg59@srcf.ucam.org>,
        "Peter Jones" <pjones@redhat.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>,
        "AKASHI Takahiro" <takahiro.akashi@linaro.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Xi Ruoyao" <xry111@xry111.site>,
        "Lennart Poettering" <lennart@poettering.net>,
        "Jeremy Linton" <jeremy.linton@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 8/8] loongarch: efi: enable generic EFI compressed
 boot
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <20220910081152.2238369-9-ardb@kernel.org>
References: <20220910081152.2238369-1-ardb@kernel.org>
 <20220910081152.2238369-9-ardb@kernel.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: +5C/XmZvb3Rlcl90eHQ9MzcyMzo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6876236f.7b0c.18327c74248.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Ax1OGBnRxj2kwWAA--.4891W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQAEBmMbLNsBGgAKsd
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGksIEFyZCwKCkkgcHJlZmVyIHRvIGdpdmUgYSBjaGFuY2UgdG8gZGlzYWJsZSBaQk9PVCwgc28g
SSBkb24ndCB3YW50IHRvIHNlbGVjdCBFRklfWkJPT1QgdW5jb25kaXRpb25hbGx5IGluIEtjb25m
aWcsIGFuZCB0aGVuIHRoZSBNYWtlZmlsZSBjYW4gYmUgbGlrZSB0aGlzOgpkaWZmIC0tZ2l0IGEv
YXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUgYi9hcmNoL2xvb25nYXJjaC9NYWtlZmlsZQppbmRleCBj
M2Y1NzliZGY5ZTUuLmJjNmZlNjUxMjVmNSAxMDA2NDQKLS0tIGEvYXJjaC9sb29uZ2FyY2gvTWFr
ZWZpbGUKKysrIGIvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUKQEAgLTE0LDYgKzE0LDEwIEBAIGVs
c2UKIEtCVUlMRF9JTUFHRSAgIDo9ICQoYm9vdCkvdm1saW51eC5lZmkKIGVuZGlmCgoraWZkZWYg
Q09ORklHX0VGSV9aQk9PVAorS0JVSUxEX0lNQUdFICAgIDo9ICQoYm9vdCkvdm1saW51ei5lZmkK
K2VuZGlmCisKIGFyY2hzY3JpcHRzOiBzY3JpcHRzX2Jhc2ljCiAgICAgICAgJChRKSQoTUFLRSkg
JChidWlsZCk9YXJjaC9sb29uZ2FyY2gvYm9vdC90b29scyByZWxvY3MKCkh1YWNhaQoKCj4gLS0t
LS3ljp/lp4vpgq7ku7YtLS0tLQo+IOWPkeS7tuS6ujogIkFyZCBCaWVzaGV1dmVsIiA8YXJkYkBr
ZXJuZWwub3JnPgo+IOWPkemAgeaXtumXtDoyMDIyLTA5LTEwIDE2OjExOjUyICjmmJ/mnJ/lha0p
Cj4g5pS25Lu25Lq6OiBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnCj4g5oqE6YCBOiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcsICJBcmQgQmllc2hldXZlbCIgPGFyZGJAa2VybmVsLm9yZz4sICJKYW1lcyBFLkouIEJvdHRv
bWxleSIgPEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+LCAiTWF0dGhldyBH
YXJyZXR0IiA8bWpnNTlAc3JjZi51Y2FtLm9yZz4sICJQZXRlciBKb25lcyIgPHBqb25lc0ByZWRo
YXQuY29tPiwgIklsaWFzIEFwYWxvZGltYXMiIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+
LCAiSGVpbnJpY2ggU2NodWNoYXJkdCIgPGhlaW5yaWNoLnNjaHVjaGFyZHRAY2Fub25pY2FsLmNv
bT4sICJBS0FTSEkgVGFrYWhpcm8iIDx0YWthaGlyby5ha2FzaGlAbGluYXJvLm9yZz4sICJQYWxt
ZXIgRGFiYmVsdCIgPHBhbG1lckBkYWJiZWx0LmNvbT4sICJBdGlzaCBQYXRyYSIgPGF0aXNocEBh
dGlzaHBhdHJhLm9yZz4sICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5kYi5kZT4sICJIdWFjYWkg
Q2hlbiIgPGNoZW5odWFjYWlAbG9vbmdzb24uY24+LCAiWGkgUnVveWFvIiA8eHJ5MTExQHhyeTEx
MS5zaXRlPiwgIkxlbm5hcnQgUG9ldHRlcmluZyIgPGxlbm5hcnRAcG9ldHRlcmluZy5uZXQ+LCAi
SmVyZW15IExpbnRvbiIgPGplcmVteS5saW50b25AYXJtLmNvbT4sICJXaWxsIERlYWNvbiIgPHdp
bGxAa2VybmVsLm9yZz4sICJDYXRhbGluIE1hcmluYXMiIDxjYXRhbGluLm1hcmluYXNAYXJtLmNv
bT4KPiDkuLvpopg6IFtQQVRDSCB2NSA4LzhdIGxvb25nYXJjaDogZWZpOiBlbmFibGUgZ2VuZXJp
YyBFRkkgY29tcHJlc3NlZCBib290Cj4gCj4gV2lyZSB1cCB0aGUgZ2VuZXJpYyBFRkkgemJvb3Qg
c3VwcG9ydCBmb3IgTG9vbmdBcmNoNjQKPiAKPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZl
bCA8YXJkYkBrZXJuZWwub3JnPgo+IC0tLQo+ICBhcmNoL2xvb25nYXJjaC9LY29uZmlnICAgICAg
ICAgfCAxICsKPiAgYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUgICAgICAgIHwgNCArKy0tCj4gIGFy
Y2gvbG9vbmdhcmNoL2Jvb3QvLmdpdGlnbm9yZSB8IDEgKwo+ICBhcmNoL2xvb25nYXJjaC9ib290
L01ha2VmaWxlICAgfCA2ICsrKysrKwo+ICA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL0tjb25m
aWcgYi9hcmNoL2xvb25nYXJjaC9LY29uZmlnCj4gaW5kZXggZmNhMTA2YThiOGFmLi5mOTYwZGJi
ZmI2MmQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZwo+ICsrKyBiL2FyY2gv
bG9vbmdhcmNoL0tjb25maWcKPiBAQCAtNTUsNiArNTUsNyBAQCBjb25maWcgTE9PTkdBUkNICj4g
IAlzZWxlY3QgQlVJTERUSU1FX1RBQkxFX1NPUlQKPiAgCXNlbGVjdCBDT01NT05fQ0xLCj4gIAlz
ZWxlY3QgRUZJCj4gKwlzZWxlY3QgRUZJX1pCT09UCj4gIAlzZWxlY3QgR0VORVJJQ19DTE9DS0VW
RU5UUwo+ICAJc2VsZWN0IEdFTkVSSUNfQ01PU19VUERBVEUKPiAgCXNlbGVjdCBHRU5FUklDX0NQ
VV9BVVRPUFJPQkUKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUgYi9hcmNo
L2xvb25nYXJjaC9NYWtlZmlsZQo+IGluZGV4IDRiYzQ3ZjQ3Y2ZkOC4uMzU3ZWQyYTc3MWJmIDEw
MDY0NAo+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCj4gKysrIGIvYXJjaC9sb29uZ2Fy
Y2gvTWFrZWZpbGUKPiBAQCAtMTAsNyArMTAsNyBAQCBLQlVJTERfREVGQ09ORklHIDo9IGxvb25n
c29uM19kZWZjb25maWcKPiAgaWZuZGVmIENPTkZJR19FRklfU1RVQgo+ICBLQlVJTERfSU1BR0UJ
Oj0gJChib290KS92bWxpbnV4LmVsZgo+ICBlbHNlCj4gLUtCVUlMRF9JTUFHRQk6PSAkKGJvb3Qp
L3ZtbGludXguZWZpCj4gK0tCVUlMRF9JTUFHRQk6PSAkKGJvb3QpL3ZtbGludXouZWZpCj4gIGVu
ZGlmCj4gIAo+ICAjCj4gQEAgLTkzLDcgKzkzLDcgQEAgdmRzb19pbnN0YWxsOgo+ICAKPiAgYWxs
OgkkKG5vdGRpciAkKEtCVUlMRF9JTUFHRSkpCj4gIAo+IC12bWxpbnV4LmVsZiB2bWxpbnV4LmVm
aTogdm1saW51eAo+ICt2bWxpbnV4LmVsZiB2bWxpbnV4LmVmaSB2bWxpbnV6LmVmaTogdm1saW51
eAo+ICAJJChRKSQoTUFLRSkgJChidWlsZCk9JChib290KSAkKGJvb3R2YXJzLXkpICQoYm9vdCkv
JEAKPiAgCj4gIGluc3RhbGw6Cj4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2Jvb3QvLmdp
dGlnbm9yZSBiL2FyY2gvbG9vbmdhcmNoL2Jvb3QvLmdpdGlnbm9yZQo+IGluZGV4IDQ5NDIzZWU5
NmVmMy4uZTVkYzU5NGRjNGI2IDEwMDY0NAo+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL2Jvb3QvLmdp
dGlnbm9yZQo+ICsrKyBiL2FyY2gvbG9vbmdhcmNoL2Jvb3QvLmdpdGlnbm9yZQo+IEBAIC0xLDIg
KzEsMyBAQAo+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKPiAgdm1s
aW51eCoKPiArdm1saW51eioKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvYm9vdC9NYWtl
ZmlsZSBiL2FyY2gvbG9vbmdhcmNoL2Jvb3QvTWFrZWZpbGUKPiBpbmRleCBmZWNmMzRmNTBlNTYu
LjRlMWMzNzRjNTc4MiAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9ib290L01ha2VmaWxl
Cj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvYm9vdC9NYWtlZmlsZQo+IEBAIC0xOCwzICsxOCw5IEBA
ICQob2JqKS92bWxpbnV4LmVsZjogdm1saW51eCBGT1JDRQo+ICB0YXJnZXRzICs9IHZtbGludXgu
ZWZpCj4gICQob2JqKS92bWxpbnV4LmVmaTogdm1saW51eCBGT1JDRQo+ICAJJChjYWxsIGlmX2No
YW5nZWQsb2JqY29weSkKPiArCj4gK0VGSV9aQk9PVF9QQVlMT0FEICAgICAgOj0gdm1saW51eC5l
ZmkKPiArRUZJX1pCT09UX0JGRF9UQVJHRVQgICA6PSBlbGY2NC1sb29uZ2FyY2gKPiArRUZJX1pC
T09UX01BQ0hfVFlQRSAgICA6PSBMT09OR0FSQ0g2NAo+ICsKPiAraW5jbHVkZSAkKHNyY3RyZWUp
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUuemJvb3QKPiAtLSAKPiAyLjM1
LjEKDQoNCuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reenkeeahOWVhuS4muen
mOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4
quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eU
qO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuaI
luaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmU
meaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6
uuW5tuWIoOmZpOacrOmCruS7tuOAgiANClRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBj
b250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIExvb25nc29uIFRlY2hub2xvZ3kg
LCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBh
ZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFp
bmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90
YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5hdGlvbikg
YnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGli
aXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQuIA==

