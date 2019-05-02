Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570CB121A4
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEBSHy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 14:07:54 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:44317 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEBSHy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 14:07:54 -0400
Received: by mail-io1-f47.google.com with SMTP id r71so2985976iod.11
        for <linux-efi@vger.kernel.org>; Thu, 02 May 2019 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYG9gid407fSTqcR1sS3MZsK+2t2f3wkYcvKU9idh/0=;
        b=A+QWwBszn7IF2LsKKt3bA3qQRVC/8fct9y1/eeeTerQbYsFvHI5zMXlu0aXk0vVrOn
         naL1Cr/tW58pQnINfGsDF0f4zD6E+P9VbbGdX8UWDESHru5uUOisJRcRKRD6lm5isO0W
         Pr5sUw6blHQXdjdhrkIHtdlPx1Jn+jxWk3VK77O9RL8eMM0dZlB7cqt9QqRV5rp4pfPR
         Hji3D//QPGXHr1OE9zBRF8CRHbw3l+50PAGEC01dnKXD2BIsOMb/eLhiaOizBOuW8AX6
         FUoYZXIFvT9DDpNoK4pm9QYPumEx0ejBOAlENzXSBV4o7Uruy2SZoW1w3oN+GxjGtNKk
         YqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYG9gid407fSTqcR1sS3MZsK+2t2f3wkYcvKU9idh/0=;
        b=h6dVUw6UbYuKC/pYmBc1OtdQyJFDszdPm6/tbZpZqdai1WWvuSX+gls3N3++7jDCHi
         MfaZhYpwDrlbucocz5vShcOoiSi39bITOmkLxHK7FDcPDht+qQ+NRzGIsjgP3zu3tNMR
         EW6Gsq5vnzZ+NNpkfIEfrFRqqLOBmfmzpbT21TEiQ5uw3LT9WxtutgkLmmfJu6kpvZ/I
         c9FoNDKOg7Gb988okcqSN98Vj3divPRUIIQBm32ORJByUeLQE7HlL47Tu3qWU10O9sst
         aoTsf6WcuRX6yfO0TXyFhKGNc5tVSFfPrTye8nsyu4Ug/rNpsXCLu24YY9wSHnTyuOzw
         xN1g==
X-Gm-Message-State: APjAAAUVOJRFgyfNXiiTBaUtmnp39/OmccebqfDz4KQAwjjRcAkQ2d0h
        FSmBp0ebIlAkSD9WOeFe0uQhriuOUnTPZ047T+/GDQ==
X-Google-Smtp-Source: APXvYqwPhkHRZZHAu5m0YdmhCF98yH9zmIk5u4ncpmop4ullUZT7lAZNqW2xxhBaiplIU0vZnvNIyaNtfhLTtvTUb2Y=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr3597345ioc.169.1556820473380;
 Thu, 02 May 2019 11:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
 <CACdnJuvYAfFboej4e5jQ=iwhb-5Pi7BgSKEWGqJ0q=uarCoOfQ@mail.gmail.com> <CAJzaN5ofshg4KseGhOL2LSLDQNoAHC6Ve25gpgWU69bEfBq1fw@mail.gmail.com>
In-Reply-To: <CAJzaN5ofshg4KseGhOL2LSLDQNoAHC6Ve25gpgWU69bEfBq1fw@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 May 2019 11:07:42 -0700
Message-ID: <CACdnJutMC2GBiXYUnFze+E-cigwb1gOK_wRfyWp77XQhTJuw9A@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Bartosz Szczepanek <barteks7r@gmail.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: multipart/mixed; boundary="0000000000004c18a80587eb8349"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--0000000000004c18a80587eb8349
Content-Type: text/plain; charset="UTF-8"

Sorry, how about this one? I was confused by why I wasn't hitting
this, but on closer examination it turns out that my system populates
the final event log with 0 events which means we never hit this
codepath :(

--0000000000004c18a80587eb8349
Content-Type: text/x-patch; charset="US-ASCII"; name="fix_log.diff"
Content-Disposition: attachment; filename="fix_log.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jv6yoxc70>
X-Attachment-Id: f_jv6yoxc70

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jIGIvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvdHBtLmMKaW5kZXggMmNjYWE2NjYxYWFmLi5kYjBmZGFhOWM2NjYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jCisrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL3Rw
bS5jCkBAIC0yOCw2ICsyOCw3IEBAIHN0YXRpYyBpbnQgdHBtMl9jYWxjX2V2ZW50X2xvZ19zaXpl
KHZvaWQgKmRhdGEsIGludCBjb3VudCwgdm9pZCAqc2l6ZV9pbmZvKQogCQlpZiAoZXZlbnRfc2l6
ZSA9PSAwKQogCQkJcmV0dXJuIC0xOwogCQlzaXplICs9IGV2ZW50X3NpemU7CisJCWNvdW50LS07
CiAJfQogCiAJcmV0dXJuIHNpemU7CkBAIC00MSw2ICs0Miw3IEBAIGludCBfX2luaXQgZWZpX3Rw
bV9ldmVudGxvZ19pbml0KHZvaWQpCiAJc3RydWN0IGxpbnV4X2VmaV90cG1fZXZlbnRsb2cgKmxv
Z190Ymw7CiAJc3RydWN0IGVmaV90Y2cyX2ZpbmFsX2V2ZW50c190YWJsZSAqZmluYWxfdGJsOwog
CXVuc2lnbmVkIGludCB0Ymxfc2l6ZTsKKwlpbnQgcmV0ID0gMDsKIAogCWlmIChlZmkudHBtX2xv
ZyA9PSBFRklfSU5WQUxJRF9UQUJMRV9BRERSKSB7CiAJCS8qCkBAIC02MCwxMCArNjIsOSBAQCBp
bnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQogCiAJdGJsX3NpemUgPSBzaXpl
b2YoKmxvZ190YmwpICsgbG9nX3RibC0+c2l6ZTsKIAltZW1ibG9ja19yZXNlcnZlKGVmaS50cG1f
bG9nLCB0Ymxfc2l6ZSk7Ci0JZWFybHlfbWVtdW5tYXAobG9nX3RibCwgc2l6ZW9mKCpsb2dfdGJs
KSk7CiAKIAlpZiAoZWZpLnRwbV9maW5hbF9sb2cgPT0gRUZJX0lOVkFMSURfVEFCTEVfQUREUikK
LQkJcmV0dXJuIDA7CisJCWdvdG8gb3V0OwogCiAJZmluYWxfdGJsID0gZWFybHlfbWVtcmVtYXAo
ZWZpLnRwbV9maW5hbF9sb2csIHNpemVvZigqZmluYWxfdGJsKSk7CiAKQEAgLTcxLDE3ICs3Miwy
MCBAQCBpbnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQogCQlwcl9lcnIoIkZh
aWxlZCB0byBtYXAgVFBNIEZpbmFsIEV2ZW50IExvZyB0YWJsZSBAIDB4JWx4XG4iLAogCQkgICAg
ICAgZWZpLnRwbV9maW5hbF9sb2cpOwogCQllZmkudHBtX2ZpbmFsX2xvZyA9IEVGSV9JTlZBTElE
X1RBQkxFX0FERFI7Ci0JCXJldHVybiAtRU5PTUVNOworCQlyZXQgPSAtRU5PTUVNOworCQlnb3Rv
IG91dDsKIAl9CiAKIAl0Ymxfc2l6ZSA9IHRwbTJfY2FsY19ldmVudF9sb2dfc2l6ZShmaW5hbF90
YmwtPmV2ZW50cywKIAkJCQkJICAgIGZpbmFsX3RibC0+bnJfZXZlbnRzLAotCQkJCQkgICAgKHZv
aWQgKillZmkudHBtX2xvZyk7CisJCQkJCSAgICBsb2dfdGJsLT5sb2cpOwogCW1lbWJsb2NrX3Jl
c2VydmUoKHVuc2lnbmVkIGxvbmcpZmluYWxfdGJsLAogCQkJIHRibF9zaXplICsgc2l6ZW9mKCpm
aW5hbF90YmwpKTsKIAllYXJseV9tZW11bm1hcChmaW5hbF90YmwsIHNpemVvZigqZmluYWxfdGJs
KSk7CiAJZWZpX3RwbV9maW5hbF9sb2dfc2l6ZSA9IHRibF9zaXplOwogCi0JcmV0dXJuIDA7Citv
dXQ6CisJZWFybHlfbWVtdW5tYXAobG9nX3RibCwgc2l6ZW9mKCpsb2dfdGJsKSk7CisJcmV0dXJu
IHJldDsKIH0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90cG1fZXZlbnRsb2cuaCBiL2lu
Y2x1ZGUvbGludXgvdHBtX2V2ZW50bG9nLmgKaW5kZXggZGNjYzk3ZTYxMzVjLi4xOTBhMzM5Njhh
OTEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdHBtX2V2ZW50bG9nLmgKKysrIGIvaW5jbHVk
ZS9saW51eC90cG1fZXZlbnRsb2cuaApAQCAtMTU4LDcgKzE1OCw2IEBAIHN0YXRpYyBpbmxpbmUg
aW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2
ZW50LAogewogCXN0cnVjdCB0Y2dfZWZpX3NwZWNpZF9ldmVudF9oZWFkICplZmlzcGVjaWQ7CiAJ
c3RydWN0IHRjZ19ldmVudF9maWVsZCAqZXZlbnRfZmllbGQ7Ci0Jdm9pZCAqbWFwcGluZyA9IE5V
TEw7CiAJaW50IG1hcHBpbmdfc2l6ZTsKIAl2b2lkICptYXJrZXI7CiAJdm9pZCAqbWFya2VyX3N0
YXJ0OwpAQCAtMTc2LDkgKzE3NSw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2
ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCS8qIE1hcCB0aGUg
ZXZlbnQgaGVhZGVyICovCiAJaWYgKGRvX21hcHBpbmcpIHsKIAkJbWFwcGluZ19zaXplID0gbWFy
a2VyIC0gbWFya2VyX3N0YXJ0OwotCQltYXBwaW5nID0gZWFybHlfbWVtcmVtYXAoKHVuc2lnbmVk
IGxvbmcpbWFya2VyX3N0YXJ0LAorCQlldmVudCA9IGVhcmx5X21lbXJlbWFwKCh1bnNpZ25lZCBs
b25nKW1hcmtlcl9zdGFydCwKIAkJCQkJIG1hcHBpbmdfc2l6ZSk7Ci0JCWlmICghbWFwcGluZykg
eworCQlpZiAoIWV2ZW50KSB7CiAJCQlzaXplID0gMDsKIAkJCWdvdG8gb3V0OwogCQl9CkBAIC0x
OTksOSArMTk4LDkgQEAgc3RhdGljIGlubGluZSBpbnQgX19jYWxjX3RwbTJfZXZlbnRfc2l6ZShz
dHJ1Y3QgdGNnX3Bjcl9ldmVudDJfaGVhZCAqZXZlbnQsCiAJCWlmIChkb19tYXBwaW5nKSB7CiAJ
CQllYXJseV9tZW11bm1hcChtYXBwaW5nLCBtYXBwaW5nX3NpemUpOwogCQkJbWFwcGluZ19zaXpl
ID0gbWFya2VyIC0gbWFya2VyX3N0YXJ0ICsgaGFsZ19zaXplOwotCQkJbWFwcGluZyA9IGVhcmx5
X21lbXJlbWFwKCh1bnNpZ25lZCBsb25nKW1hcmtlcl9zdGFydCwKKwkJCWV2ZW50ID0gZWFybHlf
bWVtcmVtYXAoKHVuc2lnbmVkIGxvbmcpbWFya2VyX3N0YXJ0LAogCQkJCQkJIG1hcHBpbmdfc2l6
ZSk7Ci0JCQlpZiAoIW1hcHBpbmcpIHsKKwkJCWlmICghZXZlbnQpIHsKIAkJCQlzaXplID0gMDsK
IAkJCQlnb3RvIG91dDsKIAkJCX0KQEAgLTIxOSw5ICsyMTgsOSBAQCBzdGF0aWMgaW5saW5lIGlu
dCBfX2NhbGNfdHBtMl9ldmVudF9zaXplKHN0cnVjdCB0Y2dfcGNyX2V2ZW50Ml9oZWFkICpldmVu
dCwKIAkJCQlpZiAoZG9fbWFwcGluZykgewogCQkJCQllYXJseV9tZW11bm1hcChtYXBwaW5nLCBt
YXBwaW5nX3NpemUpOwogCQkJCQltYXBwaW5nX3NpemUgPSBtYXJrZXIgLSBtYXJrZXJfc3RhcnQ7
Ci0JCQkJCW1hcHBpbmcgPSBlYXJseV9tZW1yZW1hcCgodW5zaWduZWQgbG9uZyltYXJrZXJfc3Rh
cnQsCisJCQkJCWV2ZW50ID0gZWFybHlfbWVtcmVtYXAoKHVuc2lnbmVkIGxvbmcpbWFya2VyX3N0
YXJ0LAogCQkJCQkJICAgICAgbWFwcGluZ19zaXplKTsKLQkJCQkJaWYgKCFtYXBwaW5nKSB7CisJ
CQkJCWlmICghZXZlbnQpIHsKIAkJCQkJCXNpemUgPSAwOwogCQkJCQkJZ290byBvdXQ7CiAJCQkJ
CX0KQEAgLTI0MywxMSArMjQyLDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2
ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCSAqIHdlIGRvbid0
IG5lZWQgdG8gbWFwIGl0CiAJICovCiAJaWYgKGRvX21hcHBpbmcpIHsKLQkJZWFybHlfbWVtdW5t
YXAobWFya2VyX3N0YXJ0LCBtYXBwaW5nX3NpemUpOworCQllYXJseV9tZW11bm1hcChldmVudCwg
bWFwcGluZ19zaXplKTsKIAkJbWFwcGluZ19zaXplICs9IHNpemVvZihldmVudF9maWVsZC0+ZXZl
bnRfc2l6ZSk7Ci0JCW1hcHBpbmcgPSBlYXJseV9tZW1yZW1hcCgodW5zaWduZWQgbG9uZyltYXJr
ZXJfc3RhcnQsCi0JCQkJCSBtYXBwaW5nX3NpemUpOwotCQlpZiAoIW1hcHBpbmcpIHsKKwkJZXZl
bnQgPSBlYXJseV9tZW1yZW1hcCgodW5zaWduZWQgbG9uZyltYXJrZXJfc3RhcnQsCisJCQkJICAg
ICAgIG1hcHBpbmdfc2l6ZSk7CisJCWlmICghZXZlbnQpIHsKIAkJCXNpemUgPSAwOwogCQkJZ290
byBvdXQ7CiAJCX0KQEAgLTI1Nyw4ICsyNTYsNiBAQCBzdGF0aWMgaW5saW5lIGludCBfX2NhbGNf
dHBtMl9ldmVudF9zaXplKHN0cnVjdCB0Y2dfcGNyX2V2ZW50Ml9oZWFkICpldmVudCwKIAkJKyBl
dmVudF9maWVsZC0+ZXZlbnRfc2l6ZTsKIAlzaXplID0gbWFya2VyIC0gbWFya2VyX3N0YXJ0Owog
Ci0JaWYgKChldmVudC0+ZXZlbnRfdHlwZSA9PSAwKSAmJiAoZXZlbnRfZmllbGQtPmV2ZW50X3Np
emUgPT0gMCkpCi0JCXNpemUgPSAwOwogb3V0OgogCWlmIChkb19tYXBwaW5nKQogCQllYXJseV9t
ZW11bm1hcChtYXBwaW5nLCBtYXBwaW5nX3NpemUpOwo=
--0000000000004c18a80587eb8349--
