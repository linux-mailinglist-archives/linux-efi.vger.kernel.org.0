Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06305B5C93
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiILOqX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiILOqW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 10:46:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18CC423BD5;
        Mon, 12 Sep 2022 07:46:19 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [114.216.208.34] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 12 Sep 2022 22:45:42
 +0800 (GMT+08:00)
X-Originating-IP: [114.216.208.34]
Date:   Mon, 12 Sep 2022 22:45:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Ard Biesheuvel" <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
Subject: Re: Re: Re: [PATCH v5 8/8] loongarch: efi: enable generic EFI
 compressed boot
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <CAMj1kXEvRfgMo+kJBwdNQfcBSfEXYGZ5vTbh2Ym8T6X+p9iWBA@mail.gmail.com>
References: <20220910081152.2238369-1-ardb@kernel.org>
 <20220910081152.2238369-9-ardb@kernel.org>
 <6876236f.7b0c.18327c74248.Coremail.chenhuacai@loongson.cn>
 <CAMj1kXFpQ1FkiMMXeA-E5FdnDzhZr7qmN15PNig_9KXxGNRJhQ@mail.gmail.com>
 <2c005589.7bc5.1832d12eb0c.Coremail.chenhuacai@loongson.cn>
 <CAMj1kXEvRfgMo+kJBwdNQfcBSfEXYGZ5vTbh2Ym8T6X+p9iWBA@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: K93xHmZvb3Rlcl90eHQ9NDMwNjo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <72e78c9d.7c1d.1833229c931.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Dxw+EWRh9jz3oXAA--.5038W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQAHBmMfIVwBkwAAsT
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

SGksIEFyZCwKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJBcmQgQmll
c2hldXZlbCIgPGFyZGJAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAyMi0wOS0xMiAxODox
ODowNSAo5pif5pyf5LiAKQo+IOaUtuS7tuS6ujogIumZiOWNjuaJjSIgPGNoZW5odWFjYWlAbG9v
bmdzb24uY24+Cj4g5oqE6YCBOiBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnLCBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcs
ICJKYW1lcyBFLkouIEJvdHRvbWxleSIgPEphbWVzLkJvdHRvbWxleUBoYW5zZW5wYXJ0bmVyc2hp
cC5jb20+LCAiTWF0dGhldyBHYXJyZXR0IiA8bWpnNTlAc3JjZi51Y2FtLm9yZz4sICJQZXRlciBK
b25lcyIgPHBqb25lc0ByZWRoYXQuY29tPiwgIklsaWFzIEFwYWxvZGltYXMiIDxpbGlhcy5hcGFs
b2RpbWFzQGxpbmFyby5vcmc+LCAiSGVpbnJpY2ggU2NodWNoYXJkdCIgPGhlaW5yaWNoLnNjaHVj
aGFyZHRAY2Fub25pY2FsLmNvbT4sICJBS0FTSEkgVGFrYWhpcm8iIDx0YWthaGlyby5ha2FzaGlA
bGluYXJvLm9yZz4sICJQYWxtZXIgRGFiYmVsdCIgPHBhbG1lckBkYWJiZWx0LmNvbT4sICJBdGlz
aCBQYXRyYSIgPGF0aXNocEBhdGlzaHBhdHJhLm9yZz4sICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBh
cm5kYi5kZT4sICJYaSBSdW95YW8iIDx4cnkxMTFAeHJ5MTExLnNpdGU+LCAiTGVubmFydCBQb2V0
dGVyaW5nIiA8bGVubmFydEBwb2V0dGVyaW5nLm5ldD4sICJKZXJlbXkgTGludG9uIiA8amVyZW15
LmxpbnRvbkBhcm0uY29tPiwgIldpbGwgRGVhY29uIiA8d2lsbEBrZXJuZWwub3JnPiwgIkNhdGFs
aW4gTWFyaW5hcyIgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgo+IOS4u+mimDogUmU6IFJlOiBb
UEFUQ0ggdjUgOC84XSBsb29uZ2FyY2g6IGVmaTogZW5hYmxlIGdlbmVyaWMgRUZJIGNvbXByZXNz
ZWQgYm9vdAo+IAo+IE9uIFN1biwgMTEgU2VwdCAyMDIyIGF0IDE2OjAzLCDpmYjljY7miY0gPGNo
ZW5odWFjYWlAbG9vbmdzb24uY24+IHdyb3RlOgo+ID4KPiA+Cj4gPgo+ID4KPiA+ID4gLS0tLS3l
jp/lp4vpgq7ku7YtLS0tLQo+ID4gPiDlj5Hku7bkuro6ICJBcmQgQmllc2hldXZlbCIgPGFyZGJA
a2VybmVsLm9yZz4KPiA+ID4g5Y+R6YCB5pe26Ze0OjIwMjItMDktMTAgMjI6Mjg6MDQgKOaYn+ac
n+WFrSkKPiA+ID4g5pS25Lu25Lq6OiAi6ZmI5Y2O5omNIiA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5j
bj4KPiA+ID4g5oqE6YCBOiBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnLCBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsICJK
YW1lcyBFLkouIEJvdHRvbWxleSIgPEphbWVzLkJvdHRvbWxleUBoYW5zZW5wYXJ0bmVyc2hpcC5j
b20+LCAiTWF0dGhldyBHYXJyZXR0IiA8bWpnNTlAc3JjZi51Y2FtLm9yZz4sICJQZXRlciBKb25l
cyIgPHBqb25lc0ByZWRoYXQuY29tPiwgIklsaWFzIEFwYWxvZGltYXMiIDxpbGlhcy5hcGFsb2Rp
bWFzQGxpbmFyby5vcmc+LCAiSGVpbnJpY2ggU2NodWNoYXJkdCIgPGhlaW5yaWNoLnNjaHVjaGFy
ZHRAY2Fub25pY2FsLmNvbT4sICJBS0FTSEkgVGFrYWhpcm8iIDx0YWthaGlyby5ha2FzaGlAbGlu
YXJvLm9yZz4sICJQYWxtZXIgRGFiYmVsdCIgPHBhbG1lckBkYWJiZWx0LmNvbT4sICJBdGlzaCBQ
YXRyYSIgPGF0aXNocEBhdGlzaHBhdHJhLm9yZz4sICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5k
Yi5kZT4sICJYaSBSdW95YW8iIDx4cnkxMTFAeHJ5MTExLnNpdGU+LCAiTGVubmFydCBQb2V0dGVy
aW5nIiA8bGVubmFydEBwb2V0dGVyaW5nLm5ldD4sICJKZXJlbXkgTGludG9uIiA8amVyZW15Lmxp
bnRvbkBhcm0uY29tPiwgIldpbGwgRGVhY29uIiA8d2lsbEBrZXJuZWwub3JnPiwgIkNhdGFsaW4g
TWFyaW5hcyIgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgo+ID4gPiDkuLvpopg6IFJlOiBbUEFU
Q0ggdjUgOC84XSBsb29uZ2FyY2g6IGVmaTogZW5hYmxlIGdlbmVyaWMgRUZJIGNvbXByZXNzZWQg
Ym9vdAo+ID4gPgo+ID4gPiBPbiBTYXQsIDEwIFNlcHQgMjAyMiBhdCAxNToyMiwg6ZmI5Y2O5omN
IDxjaGVuaHVhY2FpQGxvb25nc29uLmNuPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IEhpLCBBcmQs
Cj4gPiA+ID4KPiA+ID4gPiBJIHByZWZlciB0byBnaXZlIGEgY2hhbmNlIHRvIGRpc2FibGUgWkJP
T1QsIHNvIEkgZG9uJ3Qgd2FudCB0byBzZWxlY3QgRUZJX1pCT09UIHVuY29uZGl0aW9uYWxseSBp
biBLY29uZmlnLCBhbmQgdGhlbiB0aGUgTWFrZWZpbGUgY2FuIGJlIGxpa2UgdGhpczoKPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUgYi9hcmNoL2xvb25nYXJjaC9N
YWtlZmlsZQo+ID4gPiA+IGluZGV4IGMzZjU3OWJkZjllNS4uYmM2ZmU2NTEyNWY1IDEwMDY0NAo+
ID4gPiA+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCj4gPiA+ID4gKysrIGIvYXJjaC9s
b29uZ2FyY2gvTWFrZWZpbGUKPiA+ID4gPiBAQCAtMTQsNiArMTQsMTAgQEAgZWxzZQo+ID4gPiA+
ICBLQlVJTERfSU1BR0UgICA6PSAkKGJvb3QpL3ZtbGludXguZWZpCj4gPiA+ID4gIGVuZGlmCj4g
PiA+ID4KPiA+ID4gPiAraWZkZWYgQ09ORklHX0VGSV9aQk9PVAo+ID4gPiA+ICtLQlVJTERfSU1B
R0UgICAgOj0gJChib290KS92bWxpbnV6LmVmaQo+ID4gPiA+ICtlbmRpZgo+ID4gPiA+ICsKPiA+
ID4gPiAgYXJjaHNjcmlwdHM6IHNjcmlwdHNfYmFzaWMKPiA+ID4gPiAgICAgICAgICQoUSkkKE1B
S0UpICQoYnVpbGQpPWFyY2gvbG9vbmdhcmNoL2Jvb3QvdG9vbHMgcmVsb2NzCj4gPiA+ID4KPiA+
ID4KPiA+ID4gT0ssIEkgd2lsbCBmb2xkIHRoaXMgaW4uIFRoaXMgYWN0dWFsbHkgYWxpZ25zIGl0
IHdpdGggdGhlIG90aGVyCj4gPiA+IGFyY2hpdGVjdHVyZXMsIHNvIEkgcHJlZmVyIHRoaXMgYXBw
cm9hY2ggYXMgd2VsbC4KPiA+Cj4gPiBUaGFuayB5b3UsIGFuZCBpZiAibWFrZSBpbnN0YWxsIiBj
YW4gYWxzbyBoYW5kbGUgdGhlIHpib290IGNhc2UsIHRoYXQncyBldmVuIGJldHRlci4gOikKPiA+
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUgYi9hcmNoL2xvb25nYXJj
aC9NYWtlZmlsZQo+ID4gaW5kZXggYzNmNTc5YmRmOWU1Li41NDgwZmUyZGU3Y2QgMTAwNjQ0Cj4g
PiAtLS0gYS9hcmNoL2xvb25nYXJjaC9NYWtlZmlsZQo+ID4gKysrIGIvYXJjaC9sb29uZ2FyY2gv
TWFrZWZpbGUKPiA+IEBAIC0xMzcsNyArMTM3LDExIEBAIHZtbGludXguZWxmIHZtbGludXguZWZp
IHZtbGludXouZWZpOiB2bWxpbnV4Cj4gPiAgY29yZS15ICs9IGFyY2gvbG9vbmdhcmNoL2Jvb3Qv
ZHRzLwo+ID4KPiA+ICBpbnN0YWxsOgo+ID4gK2lmbmRlZiBDT05GSUdfRUZJX1pCT09UCj4gPiAg
ICAgICAgICQoUSlpbnN0YWxsIC1EIC1tIDc1NSAkKEtCVUlMRF9JTUFHRSkgJChJTlNUQUxMX1BB
VEgpL3ZtbGludXgtJChLRVJORUxSRUxFQVNFKQo+ID4gK2Vsc2UKPiA+ICsgICAgICAgJChRKWlu
c3RhbGwgLUQgLW0gNzU1ICQoS0JVSUxEX0lNQUdFKSAkKElOU1RBTExfUEFUSCkvdm1saW51ei0k
KEtFUk5FTFJFTEVBU0UpCj4gPiArZW5kaWYKPiA+ICAgICAgICAgJChRKWluc3RhbGwgLUQgLW0g
NjQ0IC5jb25maWcgJChJTlNUQUxMX1BBVEgpL2NvbmZpZy0kKEtFUk5FTFJFTEVBU0UpCj4gPiAg
ICAgICAgICQoUSlpbnN0YWxsIC1EIC1tIDY0NCBTeXN0ZW0ubWFwICQoSU5TVEFMTF9QQVRIKS9T
eXN0ZW0ubWFwLSQoS0VSTkVMUkVMRUFTRSkKPiA+Cj4gCj4gSXMgdGhlcmUgYW55IHJlYXNvbiBp
biBwYXJ0aWN1bGFyIHRoaXMgaXMgb3BlbiBjb2RlZCBsaWtlIHRoaXM/IE90aGVyCj4gYXJjaGl0
ZWN0dXJlcyBqdXN0IGRvIHNvbWV0aGluZyBsaWtlCj4gCj4gaW5zdGFsbDoKPiAgICAgJChjYWxs
IGNtZCxpbnN0YWxsKQo+IAo+IGFuZCBiZSBkb25lIHdpdGggaXQuCkl0IHNlZW1zIHRoYXQgdGhl
cmUgYXJlIHR3byBwcm9ibGVtczoKMSwgdGhlIGRlZmF1bHQgaW5zdGFsbCBzY3JpcHQgZG9lc24n
dCBpbnN0YWxsIHRoZSBjb25maWd1cmF0aW9uIGZpbGU7CjIsIHRoZSBrZXJuZWwgbmFtZSBpbiAi
aW5zdGFsbGtlcm5lbCIgaXNuJ3QgdGhlIHNhbWUgYXMgdGhlIG9wZW4gY29kZWQgdmVyc2lvbiwg
aXQgbG9va3MgbGlrZSB0aGlzOgppZiBbICRBUkNIID0gJ3BwYzY0JyAtbyAkQVJDSCA9ICdwcGMn
IF07IHRoZW4KICAgIEtFUk5FTF9OQU1FPXZtbGludXgKZWxzZQogICAgS0VSTkVMX05BTUU9dm1s
aW51egpmaQoKTWF5YmUgd2UgY2FuIHByb3ZpZGUgYW4gYXJjaC1zcGVjaWZpYyBpbnN0YWxsLnNo
IGFzIGFybTY0IGRvZXMsIGJ1dCBpdCBpcyBldmVuIG1vcmUgY29tcGxleCB0aGFuIHRoZSBvcGVu
IGNvZGVkIHZlcnNpb24uCgpIdWFjYWkKCg0KDQrmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInp
vpnoiq/kuK3np5HnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrp
naLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bk
urrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jl
iIblnLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3n
moTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53m
iJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIgDQpUaGlzIGVtYWls
IGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJv
bSBMb29uZ3NvbiBUZWNobm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBl
cnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2Yg
dGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBi
dXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0
aW9uIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4g
ZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlh
dGVseSBhbmQgZGVsZXRlIGl0LiA=
