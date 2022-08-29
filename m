Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5785A41A6
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 06:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH2EAg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH2EAf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 00:00:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21464B4B6
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 21:00:31 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [112.20.110.237] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Mon, 29 Aug 2022 11:59:32
 +0800 (GMT+08:00)
X-Originating-IP: [112.20.110.237]
Date:   Mon, 29 Aug 2022 11:59:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Xi Ruoyao" <xry111@xry111.site>
Cc:     "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
Subject: Re: Re: [PATCH v4 8/9] loongarch: avoid orphan input sections
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <00a60dc58fe182782fdc8ef834323414232104fb.camel@xry111.site>
References: <20220827083850.2702465-1-ardb@kernel.org>
 <20220827083850.2702465-9-ardb@kernel.org>
 <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
 <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com>
 <adb55eda511ad6de85936dd37f584687a22e7437.camel@xry111.site>
 <CAMj1kXGHLans85vpGzY6FbdW0w5DZ0uqT7eEk2yava=udUHY1w@mail.gmail.com>
 <00a60dc58fe182782fdc8ef834323414232104fb.camel@xry111.site>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: XSJ0o2Zvb3Rlcl90eHQ9MTk2Nzo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <9a090f8.3c9b.182e7c12b58.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8BxJeKkOQxj_aILAA--.2512W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQANBmMLWtoG2QAAs9
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

T0ssIEkgdGhpbmsgdGhpcyBpcyB0aGUgcm9vdCBjYXVzZSwgYnV0IHRoaXMgcGF0Y2ggaXMgc3Rp
bGwgd29ydGh5IHRvIGdvIDYuMC1yYzQuCgpIdWFjYWkgCgoKPiAtLS0tLeWOn+Wni+mCruS7ti0t
LS0tCj4g5Y+R5Lu25Lq6OiAiWGkgUnVveWFvIiA8eHJ5MTExQHhyeTExMS5zaXRlPgo+IOWPkemA
geaXtumXtDoyMDIyLTA4LTI4IDE3OjQ0OjI0ICjmmJ/mnJ/ml6UpCj4g5pS25Lu25Lq6OiAiQXJk
IEJpZXNoZXV2ZWwiIDxhcmRiQGtlcm5lbC5vcmc+Cj4g5oqE6YCBOiAi6ZmI5Y2O5omNIiA8Y2hl
bmh1YWNhaUBsb29uZ3Nvbi5jbj4sIGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgIkphbWVzCj4gIEUuSi4gQm90dG9tbGV5IiA8
SmFtZXMuQm90dG9tbGV5QGhhbnNlbnBhcnRuZXJzaGlwLmNvbT4sICJNYXR0aGV3IEdhcnJldHQi
IDxtamc1OUBzcmNmLnVjYW0ub3JnPiwgIlBldGVyIEpvbmVzIiA8cGpvbmVzQHJlZGhhdC5jb20+
LCAiSWxpYXMgQXBhbG9kaW1hcyIgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4sICJIZWlu
cmljaCBTY2h1Y2hhcmR0IiA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPiwgIkFL
QVNISSBUYWthaGlybyIgPHRha2FoaXJvLmFrYXNoaUBsaW5hcm8ub3JnPiwgIlBhbG1lciBEYWJi
ZWx0IiA8cGFsbWVyQGRhYmJlbHQuY29tPiwgIkF0aXNoCj4gIFBhdHJhIiA8YXRpc2hwQGF0aXNo
cGF0cmEub3JnPiwgIkFybmQgQmVyZ21hbm4iIDxhcm5kQGFybmRiLmRlPiwgIkxlbm5hcnQKPiAg
UG9ldHRlcmluZyIgPGxlbm5hcnRAcG9ldHRlcmluZy5uZXQ+LCAiSmVyZW15IExpbnRvbiIgPGpl
cmVteS5saW50b25AYXJtLmNvbT4KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjQgOC85XSBsb29uZ2Fy
Y2g6IGF2b2lkIG9ycGhhbiBpbnB1dCBzZWN0aW9ucwo+IAo+IE9uIFN1biwgMjAyMi0wOC0yOCBh
dCAxMTozNiArMDIwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gPiBCdXQgZG9lcyB0aGUgRUxG
IHBzQUJJIGZvciBMb29uZ0FyY2ggZGVzY3JpYmUgTF9BUkNIX05PTkUgYXMgYSBkeW5hbWljCj4g
PiByZWxvY2F0aW9uPyAucmVsYS5keW4gdHlwaWNhbGx5IG9ubHkgY29udGFpbnMgcmVsb2NhdGlv
bnMgdGhhdCBhcmUKPiA+IHNwZWNpZmllZCBhcyBiZWluZyBzdWl0YWJsZSBmb3IgcnVudGltZSBy
ZWxvY2F0aW9uLgo+IAo+IEluIEJpbnV0aWxzIDIuMzkgdGhlIEJGRCBsaW5rZXIgb2Z0ZW4gb3Zl
ci1lc3RpbWF0ZSB0aGUgc2l6ZSBvZiAucmVsYS4qLgo+IEZvciBleGFtcGxlIGlmIHRoZXJlIGlz
IG9ubHkgNDIgcmVsb2NhdGlvbnMsIGl0IG1heSBhbGxvY2F0ZSB0aGUgc3BhY2UKPiBmb3IgNDcg
cmVsb2NhdGlvbnMgYW5kIGZpbGwgdGhlIHVudXNlZCBzcGFjZSBpbiB0aGUgc2VjdGlvbiB3aXRo
IHplcm8uIAo+IFRoZW4gNSBSX0xBUkNIX05PTkUgd2lsbCBhcHBlYXIuCj4gCj4gVGhpcyBoYXMg
YWxyZWFkeSBjYXVzZWQgdHJvdWJsZSB3aGVuIHdlIHJldmlld2VkIExvb25nQXJjaCBnbGliYyBw
b3J0LAo+IGJ1dCBhdCBsYXN0IHRoZSByZXZpZXdlcnMgY29uc2lkZXJlZCB1c2luZyBOT05FIHJl
bG9jYXRpb25zIGFzIGEKPiAicGFkZGluZyIgYWNjZXB0YWJsZS4gIFNvIGluIGdsaWJjIGxkLnNv
IHdpbGwgdHJlYXQgUl9MQVJDSF9OT05FIGFzIGEKPiAiZHluYW1pYyIgcmVsb2NhdGlvbiB3aXRo
IG5vIHJlYWwgZWZmZWN0Lgo+IAo+IFRoZSBpc3N1ZSAob3IgImJ1ZyIsIGlmIHdlIHdhbnQgYSBt
b3JlIHNlcmlvdXMgdGVybSkgc2VlbXMgZml4ZWQgaW4KPiBCaW51dGlscyB0cnVuaywgYnV0IEkn
dmUgbm90IHJlYnVpbHQgdGhlIGVudGlyZSBzeXN0ZW0gd2l0aCBpdCBzbyBJJ20KPiBub3Qgc3Vy
ZSBpZiBpdCdzIGNvbXBsZXRlbHkgZml4ZWQuCj4gCj4gLS0gCj4gWGkgUnVveWFvIDx4cnkxMTFA
eHJ5MTExLnNpdGU+Cj4gU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5
LCBYaWRpYW4gVW5pdmVyc2l0eQoNCg0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv
5Lit56eR55qE5ZWG5Lia56eY5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw
5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul
5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw
5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h
5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu
5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CCIA0KVGhpcyBlbWFpbCBhbmQg
aXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9v
bmdzb24gVGVjaG5vbG9neSAsIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24g
b3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBp
bmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5v
dCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9y
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkg
YW5kIGRlbGV0ZSBpdC4g
