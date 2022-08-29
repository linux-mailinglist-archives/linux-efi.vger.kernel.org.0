Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006CA5A44BB
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiH2IOi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiH2IOh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 04:14:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7DAF54CA2
        for <linux-efi@vger.kernel.org>; Mon, 29 Aug 2022 01:14:35 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [112.20.110.237] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 29 Aug 2022 16:13:33
 +0800 (GMT+08:00)
X-Originating-IP: [112.20.110.237]
Date:   Mon, 29 Aug 2022 16:13:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Xi Ruoyao" <xry111@xry111.site>
Cc:     "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Matthew Garrett" <mjg59@srcf.ucam.org>,
        "Peter Jones" <pjones@redhat.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>,
        "AKASHI Takahiro" <takahiro.akashi@linaro.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Lennart Poettering" <lennart@poettering.net>,
        "Jeremy Linton" <jeremy.linton@arm.com>
Subject: Re: Re: [PATCH v4 9/9] loongarch: efi: enable generic EFI
 compressed boot
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <ec399503712be2d79bd1ab789452028c1fdcaa32.camel@xry111.site>
References: <20220827083850.2702465-1-ardb@kernel.org>
 <20220827083850.2702465-10-ardb@kernel.org>
 <ec399503712be2d79bd1ab789452028c1fdcaa32.camel@xry111.site>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 0mAE22Zvb3Rlcl90eHQ9MzA3MTo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <34280140.3dda.182e8a9bb5a.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Axk+EudQxjDcQLAA--.2551W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQANBmMLWtoLjQAAsk
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

SGksIGFsbCwKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJYaSBSdW95
YW8iIDx4cnkxMTFAeHJ5MTExLnNpdGU+Cj4g5Y+R6YCB5pe26Ze0OjIwMjItMDgtMjggMTc6NTI6
MjAgKOaYn+acn+aXpSkKPiDmlLbku7bkuro6ICJBcmQgQmllc2hldXZlbCIgPGFyZGJAa2VybmVs
Lm9yZz4sIGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmcKPiDmioTpgIE6IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgIkphbWVzIEUuSi4gQm90dG9tbGV5IiA8SmFtZXMuQm90
dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4sICJNYXR0aGV3IEdhcnJldHQiIDxtamc1OUBz
cmNmLnVjYW0ub3JnPiwgIlBldGVyIEpvbmVzIiA8cGpvbmVzQHJlZGhhdC5jb20+LCAiSWxpYXMg
QXBhbG9kaW1hcyIgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4sICJIZWlucmljaCBTY2h1
Y2hhcmR0IiA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPiwgIkFLQVNISSBUYWth
aGlybyIgPHRha2FoaXJvLmFrYXNoaUBsaW5hcm8ub3JnPiwgIlBhbG1lciBEYWJiZWx0IiA8cGFs
bWVyQGRhYmJlbHQuY29tPiwgIkF0aXNoCj4gIFBhdHJhIiA8YXRpc2hwQGF0aXNocGF0cmEub3Jn
PiwgIkFybmQgQmVyZ21hbm4iIDxhcm5kQGFybmRiLmRlPiwgIkh1YWNhaSBDaGVuIiA8Y2hlbmh1
YWNhaUBsb29uZ3Nvbi5jbj4sICJMZW5uYXJ0IFBvZXR0ZXJpbmciIDxsZW5uYXJ0QHBvZXR0ZXJp
bmcubmV0PiwgIkplcmVteSBMaW50b24iIDxqZXJlbXkubGludG9uQGFybS5jb20+Cj4g5Li76aKY
OiBSZTogW1BBVENIIHY0IDkvOV0gbG9vbmdhcmNoOiBlZmk6IGVuYWJsZSBnZW5lcmljIEVGSSBj
b21wcmVzc2VkIGJvb3QKPiAKPiBIaSBBcmQsCj4gCj4gU2hvdWxkIHdlIGFsc28gYWRkCj4gCj4g
LS0KPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUgYi9hcmNoL2xvb25n
YXJjaC9NYWtlZmlsZQo+IGluZGV4IDA2M2E1NzhiYmRhYS4uNmVlM2Q3ODI2ODkzIDEwMDY0NAo+
IC0tLSBhL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvTWFr
ZWZpbGUKPiBAQCAtOSwxMCArOSwxNiBAQCBLQlVJTERfREVGQ09ORklHIDo9IGxvb25nc29uM19k
ZWZjb25maWcKPiAgCj4gIGlmbmRlZiBDT05GSUdfRUZJX1NUVUIKPiAgS0JVSUxEX0lNQUdFCTo9
ICQoYm9vdCkvdm1saW51eC5lbGYKPiAtZWxzZQo+ICtlbHNlICMgQ09ORklHX0VGSV9TVFVCCj4g
Kwo+ICtpZm5kZWYgQ09ORklHX0VGSV9aQk9PVAo+ICBLQlVJTERfSU1BR0UJOj0gJChib290KS92
bWxpbnV4LmVmaQo+ICtlbHNlCj4gK0tCVUlMRF9JTUFHRQk6PSAkKGJvb3QpL3ZtbGludXouZWZp
Cj4gIGVuZGlmCj4gIAo+ICtlbmRpZiAjIENPTkZJR19FRklfU1RVQgo+ICsKPiAgIwo+ICAjIFNl
bGVjdCB0aGUgb2JqZWN0IGZpbGUgZm9ybWF0IHRvIHN1YnN0aXR1dGUgaW50byB0aGUgbGlua2Vy
IHNjcmlwdC4KPiAgIwo+IAo+IC0tCj4gCj4gb3IgZG8gd2UgZGVsaWJlcmF0ZWx5IGV4cGVjdCBi
dWlsZGVycyB0byBydW4gIm1ha2Ugdm1saW51ei5lZmkiCj4gZXhwbGljaXRseT8KSSBwcmVmZXIg
dG8gYWRkIHRvIEtCVUlMRF9JTUFHRSwgd2UgY2FuIGV2ZW4gYWRkIHRvIG1ha2UgaW5zdGFsbC4K
Ckh1YWNhaQo+IAo+IE9uIFNhdCwgMjAyMi0wOC0yNyBhdCAxMDozOCArMDIwMCwgQXJkIEJpZXNo
ZXV2ZWwgd3JvdGU6Cj4gPiBXaXJlIHVwIHRoZSBnZW5lcmljIEVGSSB6Ym9vdCBzdXBwb3J0IGZv
ciBMb29uZ0FyY2g2NAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJk
YkBrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiDCoGFyY2gvbG9vbmdhcmNoL01ha2VmaWxlwqDCoMKg
wqDCoCB8IDIgKy0KPiA+IMKgYXJjaC9sb29uZ2FyY2gvYm9vdC9NYWtlZmlsZSB8IDYgKysrKysr
Cj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2xvb25nYXJjaC9NYWtlZmlsZSBiL2FyY2gvbG9vbmdh
cmNoL01ha2VmaWxlCj4gPiBpbmRleCA0YmM0N2Y0N2NmZDguLjcwNTFhOTVmN2YzMSAxMDA2NDQK
PiA+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCj4gPiArKysgYi9hcmNoL2xvb25nYXJj
aC9NYWtlZmlsZQo+ID4gQEAgLTkzLDcgKzkzLDcgQEAgdmRzb19pbnN0YWxsOgo+ID4gwqAKPiA+
IMKgYWxsOsKgwqDCoCQobm90ZGlyICQoS0JVSUxEX0lNQUdFKSkKPiA+IMKgCj4gPiAtdm1saW51
eC5lbGYgdm1saW51eC5lZmk6IHZtbGludXgKPiA+ICt2bWxpbnV4LmVsZiB2bWxpbnV4LmVmaSB2
bWxpbnV6LmVmaTogdm1saW51eAo+ID4gwqDCoMKgwqDCoMKgwqDCoCQoUSkkKE1BS0UpICQoYnVp
bGQpPSQoYm9vdCkgJChib290dmFycy15KSAkKGJvb3QpLyRACj4gPiDCoAo+ID4gwqBpbnN0YWxs
Ogo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2Jvb3QvTWFrZWZpbGUKPiA+IGIvYXJj
aC9sb29uZ2FyY2gvYm9vdC9NYWtlZmlsZQo+ID4gaW5kZXggZmVjZjM0ZjUwZTU2Li40ZTFjMzc0
YzU3ODIgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9ib290L01ha2VmaWxlCj4gPiAr
KysgYi9hcmNoL2xvb25nYXJjaC9ib290L01ha2VmaWxlCj4gPiBAQCAtMTgsMyArMTgsOSBAQCAk
KG9iaikvdm1saW51eC5lbGY6IHZtbGludXggRk9SQ0UKPiA+IMKgdGFyZ2V0cyArPSB2bWxpbnV4
LmVmaQo+ID4gwqAkKG9iaikvdm1saW51eC5lZmk6IHZtbGludXggRk9SQ0UKPiA+IMKgwqDCoMKg
wqDCoMKgwqAkKGNhbGwgaWZfY2hhbmdlZCxvYmpjb3B5KQo+ID4gKwo+ID4gK0VGSV9aQk9PVF9Q
QVlMT0FEwqDCoMKgwqDCoCA6PSB2bWxpbnV4LmVmaQo+ID4gK0VGSV9aQk9PVF9CRkRfVEFSR0VU
wqDCoCA6PSBlbGY2NC1sb29uZ2FyY2gKPiA+ICtFRklfWkJPT1RfTUFDSF9UWVBFwqDCoMKgIDo9
IExPT05HQVJDSDY0Cj4gPiArCj4gPiAraW5jbHVkZSAkKHNyY3RyZWUpL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUuemJvb3QKPiAKPiAtLSAKPiBYaSBSdW95YW8gPHhyeTEx
MUB4cnkxMTEuc2l0ZT4KPiBTY2hvb2wgb2YgQWVyb3NwYWNlIFNjaWVuY2UgYW5kIFRlY2hub2xv
Z3ksIFhpZGlhbiBVbml2ZXJzaXR5Cg0KDQrmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpno
iq/kuK3np5HnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLl
nLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrk
u6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIbl
nLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3nmoTk
v6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbp
gq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIgDQpUaGlzIGVtYWlsIGFu
ZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBM
b29uZ3NvbiBUZWNobm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNv
biBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhl
IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQg
bm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9u
IG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVj
aXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJy
b3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVs
eSBhbmQgZGVsZXRlIGl0LiA=
