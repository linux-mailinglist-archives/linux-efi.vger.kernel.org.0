Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD43FF721
	for <lists+linux-efi@lfdr.de>; Fri,  3 Sep 2021 00:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbhIBW1w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbhIBW1v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 18:27:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA5C061575
        for <linux-efi@vger.kernel.org>; Thu,  2 Sep 2021 15:26:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t19so7868654ejr.8
        for <linux-efi@vger.kernel.org>; Thu, 02 Sep 2021 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anddroptable-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kN4eb3csrx29/VOkedZo4mvLhZQO91AIvxuVSZScDhE=;
        b=fLZW43rz51anVFVX08/jjJL3LZNSECutIIlqAUkbQAwiR1bq+yaBB3GX+vxeCzgrMa
         8pl1jHEnO5URIA688SVd7q8yRPn1aUrSyZrwZJoUU0WTY1/HdJZu2QGsS4pHLihiqgoj
         FOhNvxOqbfkLVnuTtMjpaNA299aI2jWkui7+wfSGXtgt7UKau7jvuGybk93KoVMYUFWe
         9xuxWH+noJk6SWLPGXvPnGRGyyVFWxem9DY3WKgtvModeX//P9ol08+0xOYGjNBPWiPJ
         aSOJ8MinoRemgBkKCVKTb5Yoy0jVieAvIP0IUDrnRRn1tJ8yIp3rC+OaxQ3EpBwm8vvD
         00IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kN4eb3csrx29/VOkedZo4mvLhZQO91AIvxuVSZScDhE=;
        b=WJh8F/3msJNS6pOfm1CH4/MfQnJen1I1zgBhyNMJ0Bfm9+IEbb3YYhCJB8DObR1CDi
         MAQDxbyAtr13zcDRbTF+0HRgUIorfZcxn/m1PXS6Ba4cjHTDPc+KK8tBpFi+tCSMnusu
         6Hd1xuBSFjFCtcIyEDOpKti7xzWUUDtf+tw4lLdFKAbDLu12CnEf6Nfscx4pydRsej1p
         JpUqfkW1jP4LKabyfOmd/Mt3B+I5isNnqSDZIZc35SQTkgn4m3XhuCbMbiMFL8UCNG/k
         bW1d6C4KjDbsfFJSQ3HPOlEZuHn9uEMGoN2xgD7Ig4TAkpZL82Sd7nRH3iZ/1GCwUtDW
         XGpw==
X-Gm-Message-State: AOAM530h4LhEmSeuRcq0mxoUTbasFSrgPYtcsjxsuPDWFIYLF+SQrCJ8
        ekzoHF1W+mrb3E3jhihII4F9HtgIgTlLASV59naFeu9yuk/64Um1
X-Google-Smtp-Source: ABdhPJwjEQAg3cuxZ/n7P4/YKAS5abaE1pizAi17OOjpW756Gu6oHteLUIQ/rzcwAZ0liDCBWYBLMfR4FyyItbV29/I=
X-Received: by 2002:a17:907:7856:: with SMTP id lb22mr477378ejc.264.1630621610526;
 Thu, 02 Sep 2021 15:26:50 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
Date:   Fri, 3 Sep 2021 01:26:41 +0300
Message-ID: <CAGRPHE+Jn4UAV3THuK6nwF4G0R5LxT2EhQndTUqw8fOPMjWZPw@mail.gmail.com>
Subject: Increasing EFI_MMAP_NR_SLACK_SLOTS
To:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello

I had an issue in a big server in which no linux distro I tried was
able to boot. It failed with the messages:

EFI stub: ERROR: exit_boot() failed!
EFI stub: ERROR: efi_main() failed!

Digging through the rabbit hole I reached the error in the call to
efi_bs_call(get_memory_map) inside efi_exit_boot_services() in
efi-stub-helper.c which returned EFI_BUFFER_TOO_SMALL, so everything
collapsed after that.

It looks like despite what the comment suggests, the headroom was not enoug=
h.
I fixed it by increasing the value of EFI_MMAP_NR_SLACK_SLOTS to 16.

Is this the right approach to fix the issue?
Would it be ok to change the value in the mainline?

Thanks
- V=C3=ADctor
