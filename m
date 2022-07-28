Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7287E5845B7
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiG1SNS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 14:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiG1SNR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 14:13:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601774DD5;
        Thu, 28 Jul 2022 11:13:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 295ED1F9D9;
        Thu, 28 Jul 2022 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659031994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/sPBOHCizRxOcqIb2C1bdSrs3Qlw/FAQ05Po6tZjRhc=;
        b=AzXm5XX+MC3UpWh+dlZAGeBXIz9gtd5DL11I8CE4k4Uj+Ea5iloRIU7uu7hvohsSuWHfSZ
        1BcBkSPHEArrqBThIL25ZWTj/JynCsD+yi0+l4EnxyZ+OZaTacmh0THOt2zk3bNf2nl1zC
        nuKk2iH3xD34osg+BxgtE3F/+rZXMSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659031994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/sPBOHCizRxOcqIb2C1bdSrs3Qlw/FAQ05Po6tZjRhc=;
        b=DmEe4Ew8LWlNDlcIY7yZRYQhduz1tPWT79uNYPs2IKb+ina/TRIg14kvxAwqbHpbZO3xlK
        IBKf2z+4plUYrBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0CEF13427;
        Thu, 28 Jul 2022 18:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uAtRJrnR4mI5NwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 28 Jul 2022 18:13:13 +0000
Message-ID: <ad66bc12-ff8c-33fe-739c-879ddd3be117@suse.de>
Date:   Thu, 28 Jul 2022 20:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
 <8e694cb6-c3dc-74e3-6804-fc532f108523@gmail.com>
 <CAK8P3a2vJFCJmeMj-vuasUhwa2=2P+hAr=ScGhT21TcjQ1Z8Aw@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAK8P3a2vJFCJmeMj-vuasUhwa2=2P+hAr=ScGhT21TcjQ1Z8Aw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fka0dzGSHEDzxZIPDv0yrwbG"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fka0dzGSHEDzxZIPDv0yrwbG
Content-Type: multipart/mixed; boundary="------------wOfAjdQVOctUaTt2fnh0VO0v";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Markuss Broks <markuss.broks@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Helge Deller <deller@gmx.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Borislav Petkov <bp@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Tony Lindgren <tony@atomide.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Rob Herring <robh@kernel.org>
Message-ID: <ad66bc12-ff8c-33fe-739c-879ddd3be117@suse.de>
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-3-markuss.broks@gmail.com>
 <CAK8P3a2fZ9O6vSEyxY1KW71pG_Oyvwxp3zTbW2GuaSD6aj+Qfw@mail.gmail.com>
 <8e694cb6-c3dc-74e3-6804-fc532f108523@gmail.com>
 <CAK8P3a2vJFCJmeMj-vuasUhwa2=2P+hAr=ScGhT21TcjQ1Z8Aw@mail.gmail.com>
In-Reply-To: <CAK8P3a2vJFCJmeMj-vuasUhwa2=2P+hAr=ScGhT21TcjQ1Z8Aw@mail.gmail.com>

--------------wOfAjdQVOctUaTt2fnh0VO0v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjguMDcuMjIgdW0gMTc6MTYgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBUaHUsIEp1bCAyOCwgMjAyMiBhdCA0OjU3IFBNIE1hcmt1c3MgQnJva3MgPG1hcmt1c3Mu
YnJva3NAZ21haWwuY29tPiB3cm90ZToNCj4+IE9uIDcvMjgvMjIgMTc6NDgsIEFybmQgQmVy
Z21hbm4gd3JvdGU6DQo+Pj4gT24gVGh1LCBKdWwgMjgsIDIwMjIgYXQgNDoyOCBQTSBNYXJr
dXNzIEJyb2tzIDxtYXJrdXNzLmJyb2tzQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+
IEFkZCBlYXJseSBjb25zb2xlIHN1cHBvcnQgZm9yIGdlbmVyaWMgbGluZWFyIGZyYW1lYnVm
ZmVyIGRldmljZXMuDQo+Pj4+IFRoaXMgZHJpdmVyIHN1cHBvcnRzIHByb2JpbmcgZnJvbSBj
bWRsaW5lIGVhcmx5IHBhcmFtZXRlcnMNCj4+Pj4gb3IgZnJvbSB0aGUgZGV2aWNlLXRyZWUg
dXNpbmcgaW5mb3JtYXRpb24gaW4gc2ltcGxlLWZyYW1lYnVmZmVyIG5vZGUuDQo+Pj4+IFRo
ZSBFRkkgZnVuY3Rpb25hbGl0eSBzaG91bGQgYmUgcmV0YWluZWQgaW4gd2hvbGUuDQo+Pj4+
IFRoZSBkcml2ZXIgd2FzIGRpc2FibGVkIG9uIEFSTSBiZWNhdXNlIG9mIGEgYnVnIGluIGVh
cmx5X2lvcmVtYXANCj4+Pj4gaW1wbGVtZW50YXRpb24gb24gQVJNLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBNYXJrdXNzIEJyb2tzIDxtYXJrdXNzLmJyb2tzQGdtYWlsLmNvbT4N
Cj4+Pj4gLS0tDQo+Pj4+ICAgIC4uLi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50
eHQgICAgICAgICB8ICAxMiArLQ0KPj4+PiAgICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPj4+PiAgICBkcml2ZXJzL2Zpcm13YXJl
L2VmaS9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCj4+Pj4gICAgZHJpdmVy
cy9maXJtd2FyZS9lZmkvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4+Pj4g
ICAgZHJpdmVycy9maXJtd2FyZS9lZmkvZWFybHljb24uYyAgICAgICAgICAgICAgIHwgMjQ2
IC0tLS0tLS0tLS0tLS0tDQo+Pj4+ICAgIGRyaXZlcnMvdmlkZW8vZmJkZXYvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICB8ICAxMSArDQo+Pj4+ICAgIGRyaXZlcnMvdmlkZW8vZmJkZXYv
TWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4+ICAgIGRyaXZlcnMvdmlk
ZW8vZmJkZXYvZWFybHljb24uYyAgICAgICAgICAgICAgICB8IDMwMSArKysrKysrKysrKysr
KysrKysNCj4+Pg0KPj4+IEl0IGxvb2tzIGxpa2UgdGhpcyBpcyBub3QgYWN0dWFsbHkgcmVs
YXRlZCB0byBmYmRldiwgYW5kIHNpbmNlIGRyaXZlcnMgYXJlDQo+Pj4gbW92aW5nIGZyb20g
ZmJkZXYvc2ltcGxlZmIgdG93YXJkcyBkcm0vc2ltcGxlZHJtLCBtYXliZSBpdCB3b3VsZCBi
ZQ0KPj4+IGJldHRlciB0byBwdXQgdGhpcyBpbnRvIGVpdGhlciBkcml2ZXJzL2dwdS9kcm0v
dGlueS8gb3IgcG9zc2libHkNCj4+PiBkcml2ZXJzL3ZpZGVvL2NvbnNvbGUgdG8gbGV0IHRo
aXMgYmUgdXNlZCB3aXRob3V0IGVuYWJsaW5nIGZiZGV2Pw0KPj4NCj4+IElkZWFsbHkgdGhp
cyBzaG91bGRuJ3QgZGVwZW5kIG9uIGFueXRoaW5nLCBiZWNhdXNlIGl0IGlzbid0IHV0aWxp
emluZw0KPj4gYW55IG9mIGZiZGV2IGNvZGUgYW5kIHdvbid0IGJlIHV0aWxpemluZyBhbnkg
b2YgZHJtL2NvbnNvbGUgY29kZS4gSQ0KPj4gYWdyZWUgdGhhdCBlaXRoZXIgb2YgdGhvc2Ug
d291bGQgYmUgYSBiZXR0ZXIgcGxhY2UgZm9yIGl0LCBidXQgd2hpY2ggb25lDQo+PiBkbyB5
b3UgdGhpbmsgd291bGQgc3VpdCBtb3JlIGZvciB0aGlzIGRyaXZlcj8NCj4gDQo+IEkgdGhp
bmsgaWRlYWxseSB0aGlzIHdvdWxkIGJlIGludGVncmF0ZWQgd2l0aCBzaW1wbGVkcm0gaW4g
dGhlIGxvbmcgcnVuLA0KPiBidXQgSSBoYXZlIG5vIGlkZWEgd2hhdCB0aGF0IG1lYW5zIGlu
IHRlcm1zIG9mIGZ1dHVyZSBjb2RlIGNoYW5nZXMuDQo+IA0KPiBNYXliZSBUaG9tYXMgWmlt
bWVybWFubiBoYXMgYW4gaWRlYSBoZXJlLg0KDQpJdCdzIG5vdCBhIGdyYXBoaWNzIGRyaXZl
ciwgc28gaXQgZG9lc24ndCBiZWxvbmcgdG8gZmJkZXYgb3IgRFJNLiBJJ2QgDQpwdXQgdGhl
IGNvZGUgdW5kZXIgZHJpdmVycy92aWRlby9jb25zb2xlLg0KDQpEaXJlY3QgaW50ZWdyYXRp
b24gd2l0aCBzaW1wbGVkcm0gKG9yIGFueSBvdGhlciBmaXJtd2FyZSBncmFwaGljcyANCmRy
aXZlcikgaXMgcHJvYmFibHkgbm90IGFuIG9wdGlvbi4gVGhvc2UgZHJpdmVycyBvcGVyYXRl
IG9uIHBsYXRmb3JtIA0KZGV2aWNlcywgd2hpY2ggYXJlbid0IGF2YWlsYWJsZSB3aGVuIGVh
cmx5Y29uIHJ1bnMuDQoNClRoZXJlJ3Mgbm8gbWFuYWdlbWVudCBvZiBmcmFtZWJ1ZmZlciBv
d25lcnNoaXAgQUZBSUNUPyBGb3IgZmJkZXYgYW5kIA0KRFJNLCB3ZSBtYW5hZ2UgdGhlIG93
bmVyc2hpcCBvZiB0aGUgZnJhbWVidWZmZXIgbWVtb3J5LiBXaGVuIGEgZHJpdmVyIA0KdGFr
ZXMgb3ZlciB0aGUgZnJhbWVidWZmZXIsIGl0IGZpcnN0IGhhcyB0byByZW1vdmUgYW55IGRy
aXZlciBwcmV2aW91c2x5IA0Kb3duaW5nIHRoYXQgbWVtb3J5LiAgVGhhdCBhcHBhcmVudGx5
IGhhc24ndCBiZWVuIGEgbmVlZCBmb3IgZWFybHkgDQpjb25zb2xlcyBzbyBmYXIgKD8pIE1h
eWJlIHdlIHNob3VsZCBpbnRlZ3JhdGUgdGhlbSBpbnRvIHRoZSBvd25lcnNoaXAgDQptYW5h
Z2VtZW50IChzZWUgZHJpdmVycy92aWRlby9hcGVydHVyZS5jKS4NCg0KQmVzdCByZWdhcmRz
DQpUaG9tYXMNCg0KPiANCj4gICAgICAgICAgQXJuZA0KDQotLSANClRob21hcyBaaW1tZXJt
YW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFu
eQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBU
b3Rldg0K

--------------wOfAjdQVOctUaTt2fnh0VO0v--

--------------fka0dzGSHEDzxZIPDv0yrwbG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmLi0bkFAwAAAAAACgkQlh/E3EQov+B0
sA//U3PXzUAbSYFqCHnF//0Eu06L7FmUbkLuFwZLHUFEugcVusx0d81xpinBhNLmxKqABWfl6vj0
qfGznuHNoSFB0tA40/piKAa4XTPL7zFuUqKocfywJfxuqLEVg2Xni1phXMX4iWXXMoUiZU9dyooH
NXH9+5OkrHnhkANWckiwXnfdeyze1PaOZCQA5gv37J5icYz77JNOEl5wNuu619EpxZb+yIGoFHe2
kjo4hqPKUf6DtYmQ/XYRCaUK8ulWPpgtubnM72zrdTyBqyBtXcF10rRqepVNfJoeRNoz9aINVgwI
9YUmGIfG2mu+VXfXCVUsplQHjTIviSP6yJdKAD+Y0tN1LhgzUaojrPL6AIHtWmRUhKFOcOomqv5s
qWmOsZ5SdUrENkzcXsYsyFdxFck3lLfljwssyC5ucQ4e1+8CK9Yb4FqqQrsovAPKsP7LatV0/FUu
T0KThUmmIORfvPNJi/7UwuzRLcn9ynTzL38DnZxrGGQu4McaqffAbDaq1wnDZBavtvcI1OrEF71m
nbPZ0TeYZYfNI4ewFBfL69vR56ifRx73ptnWbA72XzZ5PxR1Uz3OYen6cZIUD/WB93MO9qsuTjIk
IsHHmA5WShkgwyoiJ+fMMcgFaHik0ak4jjcgM3XfCvVpHPondGlN27Wy1DMxiFyzNS579V7geW3f
9wo=
=9erw
-----END PGP SIGNATURE-----

--------------fka0dzGSHEDzxZIPDv0yrwbG--
