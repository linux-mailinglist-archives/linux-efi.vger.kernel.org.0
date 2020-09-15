Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4D26B30B
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 00:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIOW7K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 18:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgIOPIQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 11:08:16 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0974F20735;
        Tue, 15 Sep 2020 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600182485;
        bh=0xyXwfxoIK/ZtHtyv1UhPApx13+V3AjswVKHmWQ82cw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ygYgM9m/bn66TFThps3RBp45NivF6dFd2IrQJ/yJlDwq+o3zu/o2aXDe6+eKuDFFz
         PLLsQ5OEiyl8vcGmQlSZWp4uw3iOkasAeQDPaNPVyDxLa52lXu5nBpOszYtGNCwRIM
         hbR9tQ38wmTvZhW+cfAbHF0TeKDmXRRnJU7erbZk=
Received: by mail-oi1-f169.google.com with SMTP id w16so4261576oia.2;
        Tue, 15 Sep 2020 08:08:05 -0700 (PDT)
X-Gm-Message-State: AOAM531F8ap7J0dJU1XWJGrxggT/aZsMubkyEK7G88FkSdI52fQMwtVC
        IhP+FTEgkEB01Kq2blNlwyg3KC5Nca4ZU26xqdM=
X-Google-Smtp-Source: ABdhPJzAG3ESL6xwQvsmKw3etkopo2FiMleIRFHatfSzighPVWG+gBwRKvRcbxo96nRRSLkkjrR7A+yRyZJlrGpN1hs=
X-Received: by 2002:a54:4517:: with SMTP id l23mr3918280oil.174.1600182484304;
 Tue, 15 Sep 2020 08:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143544.155096-1-alex.kluver@hpe.com>
In-Reply-To: <20200819143544.155096-1-alex.kluver@hpe.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Sep 2020 18:07:53 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHHJD3cAvHiYbyj_BjVeeF6Oq3Fu92rZng_QE0BMsxOJw@mail.gmail.com>
Message-ID: <CAMj1kXHHJD3cAvHiYbyj_BjVeeF6Oq3Fu92rZng_QE0BMsxOJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] UEFI v2.8 Memory Error Record Updates
To:     Alex Kluver <alex.kluver@hpe.com>
Cc:     linux-edac@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, Borislav Petkov <bp@alien8.de>,
        russ.anderson@hpe.com, Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        kluveralex@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Aug 2020 at 17:36, Alex Kluver <alex.kluver@hpe.com> wrote:
>
> The UEFI Specification v2.8, Table 299, Memory Error Record has
> several changes from previous versions. Bits 18 through 21 have been
> added to the memory validation bits to include an extended version
> of row, an option to print bank address and group separately, and chip id.
> These patches implement bits 18 through 21 into the Memory Error Record.
>
> Change reserved field to extended field in cper_sec_mem_err structure
> and added the extended field to the cper_mem_err_compact structure.
>
> Print correct versions of row, bank, and chip ID.
> ---
> v1 -> v2:
>    * Add static inline cper_get_mem_extension to make
>      it more readable, as suggested by Borislav Petkov
>
>    * Add second patch for bank field, bank group, and chip id.
> ---
> Alex Kluver (2):
>   edac,ghes,cper: Add Row Extension to Memory Error Record
>   cper,edac,efi: Memory Error Record: bank group/address and chip id
>
>  drivers/edac/ghes_edac.c    | 17 +++++++++++++++--
>  drivers/firmware/efi/cper.c | 18 ++++++++++++++++--
>  include/linux/cper.h        | 24 ++++++++++++++++++++++--
>  3 files changed, 53 insertions(+), 6 deletions(-)
>

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>
