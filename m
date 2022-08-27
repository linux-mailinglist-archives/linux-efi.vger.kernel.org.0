Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB815A36F2
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiH0KQH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiH0KQF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 06:16:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6D522B19F
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 03:16:03 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [49.73.44.206] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Sat, 27 Aug 2022 18:15:37
 +0800 (GMT+08:00)
X-Originating-IP: [49.73.44.206]
Date:   Sat, 27 Aug 2022 18:15:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "Ard Biesheuvel" <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        "Jeremy Linton" <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 8/9] loongarch: avoid orphan input sections
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <20220827083850.2702465-9-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
 <20220827083850.2702465-9-ardb@kernel.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 00hrmGZvb3Rlcl90eHQ9MjMwNDo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8BxJeLJ7gljrs8KAA--.2413W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQALBmMIt9kK0gALsa
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

SGksIEFyZCwKCkl0IHNlZW1zIHRoYXQgdGhpcyBwYXRjaCBpcyBhIG5vcm1hbCBidWdmaXggYW5k
IGhhcyBubyByZWxhdGlvbiB3aXRoIHRoaXMgc2VyaWVzLiBJZiBzbywgSSBwcmVmZXIgdG8gdGFr
ZSBpbnRvIGxvb25nYXJjaC1maXhlcyBmb3IgNi4wLXJjNC4gVGhhbmtzLgoKSHVhY2FpCgoKPiAt
LS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQXJkIEJpZXNoZXV2ZWwiIDxhcmRi
QGtlcm5lbC5vcmc+Cj4g5Y+R6YCB5pe26Ze0OjIwMjItMDgtMjcgMTY6Mzg6NDkgKOaYn+acn+WF
rSkKPiDmlLbku7bkuro6IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmcKPiDmioTpgIE6IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgIkFyZCBCaWVzaGV1dmVsIiA8YXJkYkBr
ZXJuZWwub3JnPiwgIkphbWVzIEUuSi4gQm90dG9tbGV5IiA8SmFtZXMuQm90dG9tbGV5QEhhbnNl
blBhcnRuZXJzaGlwLmNvbT4sICJNYXR0aGV3IEdhcnJldHQiIDxtamc1OUBzcmNmLnVjYW0ub3Jn
PiwgIlBldGVyIEpvbmVzIiA8cGpvbmVzQHJlZGhhdC5jb20+LCAiSWxpYXMgQXBhbG9kaW1hcyIg
PGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4sICJIZWlucmljaCBTY2h1Y2hhcmR0IiA8aGVp
bnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPiwgIkFLQVNISSBUYWthaGlybyIgPHRha2Fo
aXJvLmFrYXNoaUBsaW5hcm8ub3JnPiwgIlBhbG1lciBEYWJiZWx0IiA8cGFsbWVyQGRhYmJlbHQu
Y29tPiwgIkF0aXNoIFBhdHJhIiA8YXRpc2hwQGF0aXNocGF0cmEub3JnPiwgIkFybmQgQmVyZ21h
bm4iIDxhcm5kQGFybmRiLmRlPiwgIkh1YWNhaSBDaGVuIiA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5j
bj4sICJYaSBSdW95YW8iIDx4cnkxMTFAeHJ5MTExLnNpdGU+LCAiTGVubmFydCBQb2V0dGVyaW5n
IiA8bGVubmFydEBwb2V0dGVyaW5nLm5ldD4sICJKZXJlbXkgTGludG9uIiA8amVyZW15LmxpbnRv
bkBhcm0uY29tPgo+IOS4u+mimDogW1BBVENIIHY0IDgvOV0gbG9vbmdhcmNoOiBhdm9pZCBvcnBo
YW4gaW5wdXQgc2VjdGlvbnMKPiAKPiBFbnN1cmUgdGhhdCBhbGwgaW5wdXQgc2VjdGlvbnMgYXJl
IGxpc3RlZCBleHBsaWNpdGx5IGluIHRoZSBsaW5rZXIKPiBzY3JpcHQsIGFuZCBpc3N1ZSBhIHdh
cm5pbmcgb3RoZXJ3aXNlLiBUaGlzIGVuc3VyZXMgdGhhdCB0aGUgYmluYXJ5Cj4gaW1hZ2UgbWF0
Y2hlcyB0aGUgUEUvQ09GRiBhbmQgb3RoZXIgaW1hZ2UgbWV0YWRhdGEgZXhhY3RseSwgd2hpY2gg
aXMKPiBpbXBvcnRhbnQgZm9yIHRoaW5ncyBsaWtlIGNvZGUgc2lnbmluZy4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgo+IC0tLQo+ICBhcmNoL2xv
b25nYXJjaC9LY29uZmlnICAgICAgICAgICAgICB8IDEgKwo+ICBhcmNoL2xvb25nYXJjaC9rZXJu
ZWwvdm1saW51eC5sZHMuUyB8IDIgKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZyBiL2FyY2gvbG9vbmdh
cmNoL0tjb25maWcKPiBpbmRleCBmY2ExMDZhOGI4YWYuLjQwNzUwMmRhNDMzNSAxMDA2NDQKPiAt
LS0gYS9hcmNoL2xvb25nYXJjaC9LY29uZmlnCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvS2NvbmZp
Zwo+IEBAIC01MSw2ICs1MSw3IEBAIGNvbmZpZyBMT09OR0FSQ0gKPiAgCXNlbGVjdCBBUkNIX1VT
RV9DTVBYQ0hHX0xPQ0tSRUYKPiAgCXNlbGVjdCBBUkNIX1VTRV9RVUVVRURfUldMT0NLUwo+ICAJ
c2VsZWN0IEFSQ0hfV0FOVF9ERUZBVUxUX1RPUERPV05fTU1BUF9MQVlPVVQKPiArCXNlbGVjdCBB
UkNIX1dBTlRfTERfT1JQSEFOX1dBUk4KPiAgCXNlbGVjdCBBUkNIX1dBTlRTX05PX0lOU1RSCj4g
IAlzZWxlY3QgQlVJTERUSU1FX1RBQkxFX1NPUlQKPiAgCXNlbGVjdCBDT01NT05fQ0xLCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC9sb29u
Z2FyY2gva2VybmVsL3ZtbGludXgubGRzLlMKPiBpbmRleCAzNmQwNDI3MzlmM2MuLjE3ZDMzMzA4
ZGZiYSAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvdm1saW51eC5sZHMuUwo+
ICsrKyBiL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC92bWxpbnV4Lmxkcy5TCj4gQEAgLTc0LDYgKzc0
LDggQEAgU0VDVElPTlMKPiAgCQlFWElUX0RBVEEKPiAgCX0KPiAgCj4gKwkucmVsYS5keW4gOiB7
ICooLnJlbGEuZHluKSAqKC5yZWxhKikgfQo+ICsKPiAgI2lmZGVmIENPTkZJR19TTVAKPiAgCVBF
UkNQVV9TRUNUSU9OKDEgPDwgQ09ORklHX0wxX0NBQ0hFX1NISUZUKQo+ICAjZW5kaWYKPiAtLSAK
PiAyLjM1LjEKDQoNCuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reenkeeahOWV
huS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WH
uueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8
j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWk
jeWItuaIluaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWmguae
nOaCqOmUmeaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWP
keS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuOAgiANClRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2ht
ZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIExvb25nc29uIFRlY2hu
b2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3
aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24g
Y29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0
bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5h
dGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMg
cHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUg
aXQuIA==
