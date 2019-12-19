Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D99126E56
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2019 21:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfLSUFY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Dec 2019 15:05:24 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36606 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUFX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Dec 2019 15:05:23 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so5925604iln.3
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dBWAUxAaj0iyeB33Wyu9GZhn/lVyf3MeksH3Ml/afg=;
        b=DhsrlN7CEukhujI6e8oVqLBBRJx1Ob6JXX4REOPMI9+kYnFZNRjdSMefQyO04+RPOw
         e7ii3syCb9rTRfGMsKQ9VF5drxdWkqmGT6b/d8ofGD9oPLz4Uxlh+9VYg7ghCheJfpqy
         zXd1QjI65ip9czfUIs3JywouLZuZx5jqjiTUO7OXeLFdR/sPQHJwwg0Yt2Nfyu3YFXMe
         qBB78wIJheqS19tCnaYWzWX1UJS/qyGDHmE4x1Jabn204uXOPD1UpZ45d6b34iOaeJPa
         62YUUg7CR7VxgANxFKPH+J273V3UlaqWBzIJFUpSGrwiNxH4lLtm3L588VfWh6qYgLkP
         LaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dBWAUxAaj0iyeB33Wyu9GZhn/lVyf3MeksH3Ml/afg=;
        b=EcflXOKRmAEuUpLHgZwqnENIV960cFl2LqpWm5n89musxx4TusUkrVj/vgp4RiRsQV
         1CJCn+RL4lGhyYbtdtcp0aIPHF1Erz6tGXToHyMI8U1nIXdSs66if/G14HDTxnZ1IN+n
         mG3UBSDThOjeCDCGf/C/hg3EUNtophz0a7wVGBu5IGJmJDpcb+5jP28FJ5v+yl+Rn5n1
         PpAnzZ9SQ//pHFz4xz7jfJ3XHCY95KvGWrx3w0avkcIhmsiY1Ij7Q2gQxajkjDkMritw
         UxXuRBKQCet0xoUjq84lsnbxnXxrwx8SBAFpdVVPpmr1ZscAbXBX31X3+azNV8+HPC6S
         v/DQ==
X-Gm-Message-State: APjAAAWkXqEk9w4ss9ij0kufwnpo+vvlN4dorS2Ei8Yu22bHks9XnHyX
        KLBr5ThqULzMiUDnD/2sp8js0Q8oDw3eoy3WyQOVQgl2
X-Google-Smtp-Source: APXvYqybSM1QLN1UQ8Ok67Exczq3mKfSbwSlrH0Omb2sCd+ntcDUlXytYAXP6628uG1RIw403lRzW7NUh3E0PJVEL2o=
X-Received: by 2002:a92:d642:: with SMTP id x2mr8711405ilp.169.1576785908006;
 Thu, 19 Dec 2019 12:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
In-Reply-To: <20191218170139.9468-22-ardb@kernel.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 19 Dec 2019 12:04:56 -0800
Message-ID: <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> +       status = efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SERVICES,
> +                               TPL_CALLBACK, handle_exit_boot_services_event,
> +                               NULL, &exit_boot_services_event);
> +       if (status != EFI_SUCCESS) {
> +               pr_efi_err("Failed to register for EBS() event\n");
> +               goto free_handle;
> +       }

OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
first?
