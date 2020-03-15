Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35948185D50
	for <lists+linux-efi@lfdr.de>; Sun, 15 Mar 2020 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgCON4s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 Mar 2020 09:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgCON4s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 15 Mar 2020 09:56:48 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1F6206E9
        for <linux-efi@vger.kernel.org>; Sun, 15 Mar 2020 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584280607;
        bh=65g2EkvFjqa4aRODzgO3QEsISbpGiHFGufzG7mCg/6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Ut9Vq2XeLwVUWixQe+u6mS9JK8rSwxjOXDXDapmMlC2Qgm9tWvc6YOGwDdyUpoOe
         JAmEuqlAR8oA6vYZQ9iAtjlDU6U5JHBGZMKqd+SM7WSPexIzypd3m82eI9fgefVPnP
         oVxlVVC029l4vWoEmD5s0b+4iwI7Twkwy61Bz2Wg=
Received: by mail-wr1-f46.google.com with SMTP id b2so11682673wrj.10
        for <linux-efi@vger.kernel.org>; Sun, 15 Mar 2020 06:56:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ15IhZ3YpJTLNDCvPBNG7JJmas2r5GUCo9xXAU+17nTLi5PlmYV
        FR347DoCaTm2jcMD+zBQRXRhSTmdo4EGx0EigfEyJQ==
X-Google-Smtp-Source: ADFU+vv8smGJHK3h/RpC+BEyvZo9MrDZkiTofh5W1wMFjVebPqwrhja1B0qyHv1cvSUJaIk6a94T3fsLWdVcXFQxByY=
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr30814068wrw.252.1584280605521;
 Sun, 15 Mar 2020 06:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200312011312.70653-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20200312011312.70653-1-qiuxu.zhuo@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 15 Mar 2020 09:56:34 -0400
X-Gmail-Original-Message-ID: <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
Message-ID: <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add capsule-pstore backend support
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 11 Mar 2020 at 21:12, Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
>
> Change Log v5->v6:
>   Part1: No changes.
>   Part2: Update capsule-pstore.c file header.
>          Move the variable 'efi_capsule_pstore_info' backward (for removing some function declarations).
>

This conflicts badly with the efi/core changes queued up in the tip
tree (and hence linux-next) Please rebase and repost


>
> History:
>   The v5 was sent about two years ago [1]. At that time there was a concern about the EFI system table
>   entry 'CapsulePtr' as below: whether it was an array of capsules or an array of pointers to capsules.
>
>       typedef struct { UINT32 CapsuleArrayNumber; VOID* CapsulePtr[1]; } EFI_CAPSULE_TABLE;
>
>   The latest UEFI specification v2.8 [2] has a clarification in P268 for 'CapsulePtr'  as below:
>
>       "CapsulePtr A pointer to an array of capsules that contain the same CapsuleGuid value.
>        Each CapsulePtr points to an instance of an EFI_CAPSULE_HEADER, with the capsule data
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>        concatenated on its end."
>        ^^^^^^^^^^^^^^^^^^^^^^^
>
>   According to the highlighted description above, the 'CapsulePtr' should be an array of pointers to capsules.
>   The capsule-pstore driver and the tested BIOS also use the 'CapsulePtr' as an array of pointers to capsules.
>
>
> Test:
>   The v6 is well-tested on an Intel Kaby Lake client platform + BIOS(10/24/2016) and an Intel Ice Lake
>   client platform + BIOS(09/12/2019).
>
> Reference:
>   [1] https://lore.kernel.org/linux-efi/?q=capsule-pstore
>   [2] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_A_Feb14.pdf
>
> Qiuxu Zhuo (2):
>   efi: Add 'nr_config_table' variable in efi structure
>   eif/capsule-pstore: Add capsule pstore backend
>
>  arch/x86/platform/efi/efi.c           |   1 +
>  drivers/firmware/efi/Kconfig          |  21 +
>  drivers/firmware/efi/Makefile         |   1 +
>  drivers/firmware/efi/arm-init.c       |   4 +-
>  drivers/firmware/efi/capsule-pstore.c | 692 ++++++++++++++++++++++++++
>  drivers/firmware/efi/efi.c            |   1 +
>  include/linux/efi.h                   |   1 +
>  7 files changed, 720 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/capsule-pstore.c
>
> --
> 2.17.1
>
