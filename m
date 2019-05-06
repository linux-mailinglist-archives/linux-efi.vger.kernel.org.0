Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEC1545C
	for <lists+linux-efi@lfdr.de>; Mon,  6 May 2019 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEFTUY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 May 2019 15:20:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41022 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEFTUX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 May 2019 15:20:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so16410976edd.8
        for <linux-efi@vger.kernel.org>; Mon, 06 May 2019 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCEOfP6RU+Gi012NBQNwokWykodrMshPYU6zq/Z/KZY=;
        b=qm9WwefTgIVd/AuxC2X/UkSXNHeXEUJIucqVKEb9qzx4dXtes0/cjgCt2cJ48DgCRy
         el1Uv1BBkymRxv+k4F+24XVkboutPvSRpH2Yz7B4fj9uBPWaNpKlQP+RRzmbSXmBaZqt
         8pJmQ0YW8tZWKmv8basi9LO/7bWgpXd7tZGdr+SA46tG9+a2akFmXmTjNctab92bIsLN
         P8N9jCs86CbK79QgFOvWYl5bpf/TPDgs54/HMYBbLGjaBj3qdGoLHOZsQFUbb13CEf51
         bJdxh8C3cLyYXKlxmB40Jor4cx97gNP3bR7GM2rIdIVHk1xxXTltHcwLSn+IfibV8E6/
         lr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCEOfP6RU+Gi012NBQNwokWykodrMshPYU6zq/Z/KZY=;
        b=FhiajKA9D22zz33O4FZtoCFQ+EMawGcUWLqIxeNR0iEy4FGQECu1YpFvZTOPxBq4tU
         k5LwAHb6bV5dHIJsj9sOaYdvGxKk65NhfJF5np6Vfwlq1S7IdGzrDroY+hMssHvRVKfG
         tmsXC18NslidrRHP6d73J+f6T0ndrxml6qiduthGiPKD9NRs6YkhH4w8xhUVQQRPTF4M
         VAQGq48+qHpZvluhJBmv+Ks3T82HzFhlEUro/AF2w+NrnngdcR83/QSRPXI2nce9Dc/+
         JG5zcCfeXqBJDpSD3gHtOdCBp1MlddrgddgILNR7auyPIPq96GO6XLLdBZVf18+5vMLG
         mJtg==
X-Gm-Message-State: APjAAAWeL16INPoBNFrMszqho/QTFVeLEZlA2SnlD8ayaHlk3AKsDoSP
        hwFbkMwguZfOpIRJ1r65ssAwhPhemIwKUPzHE7U=
X-Google-Smtp-Source: APXvYqwwW8R3mPN+12OrIBYktTLJSDqTG2StpnlYYtwsbwkaEu9XkYeZXx9+yBNTJKa4QrDYsy1hlA==
X-Received: by 2002:a50:95d6:: with SMTP id x22mr11190387eda.89.1557170421485;
        Mon, 06 May 2019 12:20:21 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id l6sm1758248eja.91.2019.05.06.12.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 12:20:19 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id b10so17257417wmj.4;
        Mon, 06 May 2019 12:20:18 -0700 (PDT)
X-Received: by 2002:a1c:4d04:: with SMTP id o4mr7992563wmh.126.1557170418422;
 Mon, 06 May 2019 12:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
 <CACdnJuvYAfFboej4e5jQ=iwhb-5Pi7BgSKEWGqJ0q=uarCoOfQ@mail.gmail.com>
 <CAJzaN5ofshg4KseGhOL2LSLDQNoAHC6Ve25gpgWU69bEfBq1fw@mail.gmail.com> <CACdnJutMC2GBiXYUnFze+E-cigwb1gOK_wRfyWp77XQhTJuw9A@mail.gmail.com>
In-Reply-To: <CACdnJutMC2GBiXYUnFze+E-cigwb1gOK_wRfyWp77XQhTJuw9A@mail.gmail.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Mon, 6 May 2019 21:20:06 +0200
X-Gmail-Original-Message-ID: <CAJzaN5pyjZp5A1Qcd0PRfo=zYjBeTuh6dA1nH2mS0s4Gu0b0BA@mail.gmail.com>
Message-ID: <CAJzaN5pyjZp5A1Qcd0PRfo=zYjBeTuh6dA1nH2mS0s4Gu0b0BA@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: multipart/mixed; boundary="000000000000a5911e05883cfd42"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--000000000000a5911e05883cfd42
Content-Type: text/plain; charset="UTF-8"

Nope, it doesn't work. It compiled (after correcting one more leftover
mapping), but panicked the same way.

I've came up with a set of changes that make it working in my setup,
see attached patch. There was a problem with passing already remapped
address to tpm2_calc_event_log_size(), which tried to remap it for
second time. Few more adjustments were needed in remap-as-you-go code
so that new address is used consequently. Also, I've removed remapping
digest itself because it was never used.

I'm not certain these changes make it 100% correct, but it worked on
35 events I had in final log. Its ending seems fine now:
> [root@localhost ~]# hexdump -C /sys/kernel/security/tpm0/binary_bios_measurements | tail
> 00003720  42 6f 6f 74 20 53 65 72  76 69 63 65 73 20 49 6e  |Boot Services In|
> 00003730  76 6f 63 61 74 69 6f 6e  05 00 00 00 07 00 00 80  |vocation........|
> 00003740  02 00 00 00 04 00 47 55  45 dd c9 78 d7 bf d0 36  |......GUE..x...6|
> 00003750  fa cc 7e 2e 98 7f 48 18  9f 0d 0b 00 b5 4f 75 42  |..~...H......OuB|
> 00003760  cb d8 72 a8 1a 9d 9d ea  83 9b 2b 8d 74 7c 7e bd  |..r.......+.t|~.|
> 00003770  5e a6 61 5c 40 f4 2f 44  a6 db eb a0 28 00 00 00  |^.a\@./D....(...|
> 00003780  45 78 69 74 20 42 6f 6f  74 20 53 65 72 76 69 63  |Exit Boot Servic|
> 00003790  65 73 20 52 65 74 75 72  6e 65 64 20 77 69 74 68  |es Returned with|
> 000037a0  20 53 75 63 63 65 73 73                           | Success|
> 000037a8

Still, some refactoring could help here as __calc_tpm2_event_size has
grown and its logic became hard to follow. IMO it's far too complex
for inline function.

Attached patch should be applied on top of jjs/master.

Bartosz

--000000000000a5911e05883cfd42
Content-Type: text/x-patch; charset="US-ASCII"; name="eventlog_fix.diff"
Content-Disposition: attachment; filename="eventlog_fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jvcqvyjp0>
X-Attachment-Id: f_jvcqvyjp0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jIGIvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvdHBtLmMKaW5kZXggZmU0ODE1MGYwNmQxLi4yYzkxMmVhMDgxNjYgMTAwNjQ0Ci0tLSBh
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
MiBAQCBpbnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQogCQlwcl9lcnIoIkZh
aWxlZCB0byBtYXAgVFBNIEZpbmFsIEV2ZW50IExvZyB0YWJsZSBAIDB4JWx4XG4iLAogCQkgICAg
ICAgZWZpLnRwbV9maW5hbF9sb2cpOwogCQllZmkudHBtX2ZpbmFsX2xvZyA9IEVGSV9JTlZBTElE
X1RBQkxFX0FERFI7Ci0JCXJldHVybiAtRU5PTUVNOworCQlyZXQgPSAtRU5PTUVNOworCQlnb3Rv
IG91dDsKIAl9CiAKLQl0Ymxfc2l6ZSA9IHRwbTJfY2FsY19ldmVudF9sb2dfc2l6ZShmaW5hbF90
YmwtPmV2ZW50cywKKwl0Ymxfc2l6ZSA9IHRwbTJfY2FsY19ldmVudF9sb2dfc2l6ZShlZmkudHBt
X2ZpbmFsX2xvZworCQkJCQkgICAgKyBzaXplb2YoZmluYWxfdGJsLT52ZXJzaW9uKQorCQkJCQkg
ICAgKyBzaXplb2YoZmluYWxfdGJsLT5ucl9ldmVudHMpLAogCQkJCQkgICAgZmluYWxfdGJsLT5u
cl9ldmVudHMsCi0JCQkJCSAgICAodm9pZCAqKWVmaS50cG1fbG9nKTsKKwkJCQkJICAgIGxvZ190
YmwtPmxvZyk7CiAJbWVtYmxvY2tfcmVzZXJ2ZSgodW5zaWduZWQgbG9uZylmaW5hbF90YmwsCiAJ
CQkgdGJsX3NpemUgKyBzaXplb2YoKmZpbmFsX3RibCkpOwogCWVhcmx5X21lbXVubWFwKGZpbmFs
X3RibCwgc2l6ZW9mKCpmaW5hbF90YmwpKTsKIAllZmlfdHBtX2ZpbmFsX2xvZ19zaXplID0gdGJs
X3NpemU7CiAKLQlyZXR1cm4gMDsKK291dDoKKwllYXJseV9tZW11bm1hcChsb2dfdGJsLCBzaXpl
b2YoKmxvZ190YmwpKTsKKwlyZXR1cm4gcmV0OwogfQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3RwbV9ldmVudGxvZy5oIGIvaW5jbHVkZS9saW51eC90cG1fZXZlbnRsb2cuaAppbmRleCAw
Y2EyN2JjMDUzYWYuLjYzMjM4Yzg0ZGMwYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC90cG1f
ZXZlbnRsb2cuaAorKysgYi9pbmNsdWRlL2xpbnV4L3RwbV9ldmVudGxvZy5oCkBAIC0xODUsOCAr
MTg1LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3RydWN0
IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCQkJc2l6ZSA9IDA7CiAJCQlnb3RvIG91dDsK
IAkJfQorCX0gZWxzZSB7CisJCW1hcHBpbmcgPSBtYXJrZXJfc3RhcnQ7CiAJfQogCisJZXZlbnQg
PSAoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKiltYXBwaW5nOworCiAJZWZpc3BlY2lkID0g
KHN0cnVjdCB0Y2dfZWZpX3NwZWNpZF9ldmVudF9oZWFkICopZXZlbnRfaGVhZGVyLT5ldmVudDsK
IAogCS8qIENoZWNrIGlmIGV2ZW50IGlzIG1hbGZvcm1lZC4gKi8KQEAgLTIwMSwzNCArMjA1LDI0
IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3RydWN0IHRjZ19w
Y3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCQkvKiBNYXAgdGhlIGRpZ2VzdCdzIGFsZ29yaXRobSBp
ZGVudGlmaWVyICovCiAJCWlmIChkb19tYXBwaW5nKSB7CiAJCQlUUE1fTUVNVU5NQVAobWFwcGlu
ZywgbWFwcGluZ19zaXplKTsKLQkJCW1hcHBpbmdfc2l6ZSA9IG1hcmtlciAtIG1hcmtlcl9zdGFy
dCArIGhhbGdfc2l6ZTsKLQkJCW1hcHBpbmcgPSBUUE1fTUVNUkVNQVAoKHVuc2lnbmVkIGxvbmcp
bWFya2VyX3N0YXJ0LAotCQkJCQkgICAgICAgbWFwcGluZ19zaXplKTsKKwkJCW1hcHBpbmdfc2l6
ZSA9IGhhbGdfc2l6ZTsKKwkJCW1hcHBpbmcgPSBUUE1fTUVNUkVNQVAoKHVuc2lnbmVkIGxvbmcp
bWFya2VyLAorCQkJCQkgICAgIG1hcHBpbmdfc2l6ZSk7CiAJCQlpZiAoIW1hcHBpbmcpIHsKIAkJ
CQlzaXplID0gMDsKIAkJCQlnb3RvIG91dDsKIAkJCX0KKwkJfSBlbHNlIHsKKwkJCW1hcHBpbmcg
PSBtYXJrZXI7CiAJCX0KIAotCQltZW1jcHkoJmhhbGcsIG1hcmtlciwgaGFsZ19zaXplKTsKKwkJ
bWVtY3B5KCZoYWxnLCBtYXBwaW5nLCBoYWxnX3NpemUpOwogCQltYXJrZXIgPSBtYXJrZXIgKyBo
YWxnX3NpemU7CiAKIAkJZm9yIChqID0gMDsgaiA8IGVmaXNwZWNpZC0+bnVtX2FsZ3M7IGorKykg
ewogCQkJaWYgKGhhbGcgPT0gZWZpc3BlY2lkLT5kaWdlc3Rfc2l6ZXNbal0uYWxnX2lkKSB7CiAJ
CQkJbWFya2VyICs9CiAJCQkJCWVmaXNwZWNpZC0+ZGlnZXN0X3NpemVzW2pdLmRpZ2VzdF9zaXpl
OwotCi0JCQkJLyogTWFwIHRoZSBkaWdlc3QgY29udGVudCBpdHNlbGYgKi8KLQkJCQlpZiAoZG9f
bWFwcGluZykgewotCQkJCQlUUE1fTUVNVU5NQVAobWFwcGluZywgbWFwcGluZ19zaXplKTsKLQkJ
CQkJbWFwcGluZ19zaXplID0gbWFya2VyIC0gbWFya2VyX3N0YXJ0OwotCQkJCQltYXBwaW5nID0g
VFBNX01FTVJFTUFQKCh1bnNpZ25lZCBsb25nKW1hcmtlcl9zdGFydCwKLQkJCQkJCQkgICAgICAg
bWFwcGluZ19zaXplKTsKLQkJCQkJaWYgKCFtYXBwaW5nKSB7Ci0JCQkJCQlzaXplID0gMDsKLQkJ
CQkJCWdvdG8gb3V0OwotCQkJCQl9Ci0JCQkJfQogCQkJCWJyZWFrOwogCQkJfQogCQl9CkBAIC0y
MzksMjMgKzIzMywyNSBAQCBzdGF0aWMgaW5saW5lIGludCBfX2NhbGNfdHBtMl9ldmVudF9zaXpl
KHN0cnVjdCB0Y2dfcGNyX2V2ZW50Ml9oZWFkICpldmVudCwKIAkJfQogCX0KIAotCWV2ZW50X2Zp
ZWxkID0gKHN0cnVjdCB0Y2dfZXZlbnRfZmllbGQgKiltYXJrZXI7Ci0KIAkvKgogCSAqIE1hcCB0
aGUgZXZlbnQgc2l6ZSAtIHdlIGRvbid0IHJlYWQgZnJvbSB0aGUgZXZlbnQgaXRzZWxmLCBzbwog
CSAqIHdlIGRvbid0IG5lZWQgdG8gbWFwIGl0CiAJICovCiAJaWYgKGRvX21hcHBpbmcpIHsKLQkJ
VFBNX01FTVVOTUFQKG1hcmtlcl9zdGFydCwgbWFwcGluZ19zaXplKTsKKwkJVFBNX01FTVVOTUFQ
KG1hcHBpbmcsIG1hcHBpbmdfc2l6ZSk7CiAJCW1hcHBpbmdfc2l6ZSArPSBzaXplb2YoZXZlbnRf
ZmllbGQtPmV2ZW50X3NpemUpOwotCQltYXBwaW5nID0gVFBNX01FTVJFTUFQKCh1bnNpZ25lZCBs
b25nKW1hcmtlcl9zdGFydCwKKwkJbWFwcGluZyA9IFRQTV9NRU1SRU1BUCgodW5zaWduZWQgbG9u
ZyltYXJrZXIsCiAJCQkJICAgICAgIG1hcHBpbmdfc2l6ZSk7CiAJCWlmICghbWFwcGluZykgewog
CQkJc2l6ZSA9IDA7CiAJCQlnb3RvIG91dDsKIAkJfQorCX0gZWxzZSB7CisJCW1hcHBpbmcgPSBt
YXJrZXI7CiAJfQogCisJZXZlbnRfZmllbGQgPSAoc3RydWN0IHRjZ19ldmVudF9maWVsZCAqKW1h
cHBpbmc7CisKIAltYXJrZXIgPSBtYXJrZXIgKyBzaXplb2YoZXZlbnRfZmllbGQtPmV2ZW50X3Np
emUpCiAJCSsgZXZlbnRfZmllbGQtPmV2ZW50X3NpemU7CiAJc2l6ZSA9IG1hcmtlciAtIG1hcmtl
cl9zdGFydDsK
--000000000000a5911e05883cfd42--
