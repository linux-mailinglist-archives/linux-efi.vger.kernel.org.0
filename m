Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB40C8E8A8
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2019 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfHOJ4k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Aug 2019 05:56:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45336 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730762AbfHOJ4j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Aug 2019 05:56:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so4582329otp.12
        for <linux-efi@vger.kernel.org>; Thu, 15 Aug 2019 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0MJNBM3wXQjL3kFhEpmZzh2snc0+oyZ/CNhpo2wkSSM=;
        b=h9hK5gTvHEPrOfKz58gnV1WhmUooZKvQyjMwzQHAsnr0zW0/9wUMN1U8MAtAoQn8Xs
         X9A+JSaLTRhIX/MOddRXVGxdeaE1y+8OhyNhP95awpE5YHH1lw830P0fjifBkuE4GzOh
         37PffXrh+yubgqVUjXOCD3Rte3xBi/9bHhoSCD+kkK81GTwE8y6lJEb++CdphZglV8fk
         eEzfxAutz13nSWAXsiJ1bSoJb2KbOSnrUFfGpdcXLzbuP7r7C0xlYh+szNg1YVHBaXTu
         AjufZTYZRuwAmQGW9WIu9NsI3m/INcm4yihf3IlW8KizF+R/jlB4ij2YzUyEf9jbUFHf
         FD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0MJNBM3wXQjL3kFhEpmZzh2snc0+oyZ/CNhpo2wkSSM=;
        b=B5VYpJWMg8SnXneP/IGK8tK4d7huR6mhcK2GSD5eenSC0+Li9b/IXw/Qf++NF4RfEw
         KdEyMrKYJ+yrbpLPZSDOp4hwANx4d1CX+AYd+kEqdpMPO4PC5d+iidJSYwPy3xdgFKt2
         1Ntc5YGydUQBzLvqwBrbV0KWivaSYkkkxfpF78edRtteeRtslmPF4oWelBML8dNP+y03
         0U6Xw7oMUwBIdepcy4ttHkuj8noyk93muu5wFr0lF/jWKubD8OAm7KyKVNarE0JkCswC
         Q/um8rrZ23UJ8bTpQU8MjTH5K59UU19hRqDFOARajxFRdzwnrHC7RMe4U2Qpu4YpxYX4
         bTuQ==
X-Gm-Message-State: APjAAAVsrjri8zc4DbJ7ogkw2+rM+Jfa1x6Z/LvXX629WgRCIHWymlHj
        dMVGjo659uQsOlN83v7FT4JNl8wSgmIL3X1N3TLe56Nf
X-Google-Smtp-Source: APXvYqyzyqQ/+0i45nwmipiv6meGdV7nGB5VSKkyUB0Sygw98VnXsQCRLE0xkRzQhPNpjUlLRJkyXg6hpY2x/IYkUqI=
X-Received: by 2002:a9d:c22:: with SMTP id 31mr3071697otr.48.1565862999028;
 Thu, 15 Aug 2019 02:56:39 -0700 (PDT)
MIME-Version: 1.0
From:   skodde <skodde@gmail.com>
Date:   Thu, 15 Aug 2019 05:56:27 -0400
Message-ID: <CAJrUJt_HV+8MCGxv4=bq97JFiKqPtgN4ntfei0TmxGhDT-bCQg@mail.gmail.com>
Subject: arm64/efistub boot error with CONFIG_GCC_PLUGIN_STACKLEAK
To:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

I've enabled CONFIG_GCC_PLUGIN_STACKLEAK on 5.2.8 for an arm64
macchiatobin board and I get the following error when loading the
kernel (using grub-efi on top of edk ii):

EFI stub: Booting Linux Kernel...
EFI stub: ERROR: efi_get_random_bytes() failed
EFI stub: ERROR: Failed to relocate kernel

The kernel boots fine with that option disabled, but strangely
presents the same error when disabling only CONFIG_RANDOMIZE_BASE.

Let me know if I can provide more info or do some tests.


Thanks
