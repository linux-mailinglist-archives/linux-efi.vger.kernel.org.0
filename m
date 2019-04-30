Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D81006C
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2019 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfD3TwN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Apr 2019 15:52:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36041 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3TwM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Apr 2019 15:52:12 -0400
Received: by mail-io1-f65.google.com with SMTP id d19so13313093ioc.3
        for <linux-efi@vger.kernel.org>; Tue, 30 Apr 2019 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egv8gBhUCwez9IoA3piXkzNWat3a9Q7nOx3S/lPZw9k=;
        b=G6GfZ5iaW0m25ZRTXr7m8HEFSOOargOq9Nora6opbxcB3fSBbwP2/s0zVy4fWD0gMO
         HtRmTDtnV0WxOcN40ARSbDDUFGvwrbUnaq0OYVvO/FjTl93aFXa7t9Ww5dniTcGbJKcp
         DGZ0CNe071uEHHBnsLnFdwHRHRiViAEFvK71EJ6BgRszii2X+GRxOmseslX/a/39oW6/
         PpeO4S1y3sJ/VJSrl4kjWfIv5FUtWoibeTAcwj5etuqwuT0RFjEsLNRf1qYOW/CGXJkj
         iqCVgz6HqiIeQoDlITrBqYCpuSSZkgzy6SP/3xZv1Ws995KafrjSzwUXbWE3iM7Tecp/
         KLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egv8gBhUCwez9IoA3piXkzNWat3a9Q7nOx3S/lPZw9k=;
        b=uKcwJYERagvG1jSDzNTdQKCJqsaDrwhq+5/KPfg0O8xLPqctkJbuVoEyK3uZtmjpHB
         eLNrJmdeUKjROnmgJAVoQwdnE7zZhKn5N/NvWgi4LdORUrAGww5kXRRUuHOTDqIz3dCz
         6wkKQyPMH8AviwkYAcl3W8LoCcLFrrPx6nq2hqVUXzgeRwL9eFBmklcweIGEWQVnavSE
         xti1WgHDN+Zrb6SONysyIZjzLPI90Zwa9QJzcewzH8OGgMXhQq8g45E0VYdYak5NPFsQ
         j/ZrkSY2Rz75AIrtgKKMM7YccPSmcUc7nH8By4ckvhle4XGy3vbLlRanVAtDwkvGYUKh
         nPIw==
X-Gm-Message-State: APjAAAWsREJz82awWqkOLv5kFg5WJhjoWRqF5qwK12OaKg74BSk3ucWx
        wYPav1EPLVlruai3RPeBnVadeQUS7kRZLxVYd6CQBw==
X-Google-Smtp-Source: APXvYqzwAanjZhErVbdo87uRmbq/G1eL/r6RULqQVipWeb+YzGjVdfotP+ESNQwX0xw90S+npHq/PO9QlCkqpYiwA6c=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr1259647ioc.169.1556653930964;
 Tue, 30 Apr 2019 12:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
In-Reply-To: <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 30 Apr 2019 12:51:59 -0700
Message-ID: <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Bartosz Szczepanek <bsz@semihalf.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: multipart/mixed; boundary="00000000000098970e0587c4bc96"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--00000000000098970e0587c4bc96
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 30, 2019 at 6:07 AM Bartosz Szczepanek <bsz@semihalf.com> wrote:
>
> I may be a little late with this comment, but I've just tested these
> patches on aarch64 platform (from the top of jjs/master) and got
> kernel panic ("Unable to handle kernel read", full log at the end of
> mail). I think there's problem with below call to
> tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> passed as (void *) and never remapped:

Yes, it looks like this is just broken. Can you try with the attached patch?

--00000000000098970e0587c4bc96
Content-Type: text/x-patch; charset="US-ASCII"; name="fix_log.diff"
Content-Disposition: attachment; filename="fix_log.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jv47jttc0>
X-Attachment-Id: f_jv47jttc0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jIGIvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvdHBtLmMKaW5kZXggZmU0ODE1MGYwNmQxLi45NzExYmQzNGY4YWUgMTAwNjQ0Ci0tLSBh
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
Y2x1ZGUvbGludXgvdHBtX2V2ZW50bG9nLmgKaW5kZXggMGNhMjdiYzA1M2FmLi45Y2ZiYjE0ZjU0
ZTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdHBtX2V2ZW50bG9nLmgKKysrIGIvaW5jbHVk
ZS9saW51eC90cG1fZXZlbnRsb2cuaApAQCAtMTYxLDcgKzE2MSw2IEBAIHN0YXRpYyBpbmxpbmUg
aW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2
ZW50LAogewogCXN0cnVjdCB0Y2dfZWZpX3NwZWNpZF9ldmVudF9oZWFkICplZmlzcGVjaWQ7CiAJ
c3RydWN0IHRjZ19ldmVudF9maWVsZCAqZXZlbnRfZmllbGQ7Ci0Jdm9pZCAqbWFwcGluZyA9IE5V
TEw7CiAJaW50IG1hcHBpbmdfc2l6ZTsKIAl2b2lkICptYXJrZXI7CiAJdm9pZCAqbWFya2VyX3N0
YXJ0OwpAQCAtMTc5LDkgKzE3OCw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2
ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCS8qIE1hcCB0aGUg
ZXZlbnQgaGVhZGVyICovCiAJaWYgKGRvX21hcHBpbmcpIHsKIAkJbWFwcGluZ19zaXplID0gbWFy
a2VyIC0gbWFya2VyX3N0YXJ0OwotCQltYXBwaW5nID0gVFBNX01FTVJFTUFQKCh1bnNpZ25lZCBs
b25nKW1hcmtlcl9zdGFydCwKLQkJCQkgICAgICAgbWFwcGluZ19zaXplKTsKLQkJaWYgKCFtYXBw
aW5nKSB7CisJCWV2ZW50ID0gVFBNX01FTVJFTUFQKCh1bnNpZ25lZCBsb25nKW1hcmtlcl9zdGFy
dCwKKwkJCQkgICAgIG1hcHBpbmdfc2l6ZSk7CisJCWlmICghZXZlbnQpIHsKIAkJCXNpemUgPSAw
OwogCQkJZ290byBvdXQ7CiAJCX0KQEAgLTIwMCwxMSArMTk5LDExIEBAIHN0YXRpYyBpbmxpbmUg
aW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2
ZW50LAogCiAJCS8qIE1hcCB0aGUgZGlnZXN0J3MgYWxnb3JpdGhtIGlkZW50aWZpZXIgKi8KIAkJ
aWYgKGRvX21hcHBpbmcpIHsKLQkJCVRQTV9NRU1VTk1BUChtYXBwaW5nLCBtYXBwaW5nX3NpemUp
OworCQkJVFBNX01FTVVOTUFQKGV2ZW50LCBtYXBwaW5nX3NpemUpOwogCQkJbWFwcGluZ19zaXpl
ID0gbWFya2VyIC0gbWFya2VyX3N0YXJ0ICsgaGFsZ19zaXplOwotCQkJbWFwcGluZyA9IFRQTV9N
RU1SRU1BUCgodW5zaWduZWQgbG9uZyltYXJrZXJfc3RhcnQsCi0JCQkJCSAgICAgICBtYXBwaW5n
X3NpemUpOwotCQkJaWYgKCFtYXBwaW5nKSB7CisJCQlldmVudCA9IFRQTV9NRU1SRU1BUCgodW5z
aWduZWQgbG9uZyltYXJrZXJfc3RhcnQsCisJCQkJCSAgICAgbWFwcGluZ19zaXplKTsKKwkJCWlm
ICghZXZlbnQpIHsKIAkJCQlzaXplID0gMDsKIAkJCQlnb3RvIG91dDsKIAkJCX0KQEAgLTIyMCwx
MSArMjE5LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3Ry
dWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCiAJCQkJLyogTWFwIHRoZSBkaWdlc3Qg
Y29udGVudCBpdHNlbGYgKi8KIAkJCQlpZiAoZG9fbWFwcGluZykgewotCQkJCQlUUE1fTUVNVU5N
QVAobWFwcGluZywgbWFwcGluZ19zaXplKTsKKwkJCQkJVFBNX01FTVVOTUFQKGV2ZW50LCBtYXBw
aW5nX3NpemUpOwogCQkJCQltYXBwaW5nX3NpemUgPSBtYXJrZXIgLSBtYXJrZXJfc3RhcnQ7Ci0J
CQkJCW1hcHBpbmcgPSBUUE1fTUVNUkVNQVAoKHVuc2lnbmVkIGxvbmcpbWFya2VyX3N0YXJ0LAot
CQkJCQkJCSAgICAgICBtYXBwaW5nX3NpemUpOwotCQkJCQlpZiAoIW1hcHBpbmcpIHsKKwkJCQkJ
ZXZlbnQgPSBUUE1fTUVNUkVNQVAoKHVuc2lnbmVkIGxvbmcpbWFya2VyX3N0YXJ0LAorCQkJCQkJ
CSAgICAgbWFwcGluZ19zaXplKTsKKwkJCQkJaWYgKCFldmVudCkgewogCQkJCQkJc2l6ZSA9IDA7
CiAJCQkJCQlnb3RvIG91dDsKIAkJCQkJfQpAQCAtMjQ2LDExICsyNDUsMTEgQEAgc3RhdGljIGlu
bGluZSBpbnQgX19jYWxjX3RwbTJfZXZlbnRfc2l6ZShzdHJ1Y3QgdGNnX3Bjcl9ldmVudDJfaGVh
ZCAqZXZlbnQsCiAJICogd2UgZG9uJ3QgbmVlZCB0byBtYXAgaXQKIAkgKi8KIAlpZiAoZG9fbWFw
cGluZykgewotCQlUUE1fTUVNVU5NQVAobWFya2VyX3N0YXJ0LCBtYXBwaW5nX3NpemUpOworCQlU
UE1fTUVNVU5NQVAoZXZlbnQsIG1hcHBpbmdfc2l6ZSk7CiAJCW1hcHBpbmdfc2l6ZSArPSBzaXpl
b2YoZXZlbnRfZmllbGQtPmV2ZW50X3NpemUpOwotCQltYXBwaW5nID0gVFBNX01FTVJFTUFQKCh1
bnNpZ25lZCBsb25nKW1hcmtlcl9zdGFydCwKKwkJZXZlbnQgPSBUUE1fTUVNUkVNQVAoKHVuc2ln
bmVkIGxvbmcpbWFya2VyX3N0YXJ0LAogCQkJCSAgICAgICBtYXBwaW5nX3NpemUpOwotCQlpZiAo
IW1hcHBpbmcpIHsKKwkJaWYgKCFldmVudCkgewogCQkJc2l6ZSA9IDA7CiAJCQlnb3RvIG91dDsK
IAkJfQpAQCAtMjYwLDExICsyNTksOSBAQCBzdGF0aWMgaW5saW5lIGludCBfX2NhbGNfdHBtMl9l
dmVudF9zaXplKHN0cnVjdCB0Y2dfcGNyX2V2ZW50Ml9oZWFkICpldmVudCwKIAkJKyBldmVudF9m
aWVsZC0+ZXZlbnRfc2l6ZTsKIAlzaXplID0gbWFya2VyIC0gbWFya2VyX3N0YXJ0OwogCi0JaWYg
KChldmVudC0+ZXZlbnRfdHlwZSA9PSAwKSAmJiAoZXZlbnRfZmllbGQtPmV2ZW50X3NpemUgPT0g
MCkpCi0JCXNpemUgPSAwOwogb3V0OgogCWlmIChkb19tYXBwaW5nKQotCQlUUE1fTUVNVU5NQVAo
bWFwcGluZywgbWFwcGluZ19zaXplKTsKKwkJVFBNX01FTVVOTUFQKGV2ZW50LCBtYXBwaW5nX3Np
emUpOwogCXJldHVybiBzaXplOwogfQogCg==
--00000000000098970e0587c4bc96--
