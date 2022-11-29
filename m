Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2308A63C8D9
	for <lists+linux-efi@lfdr.de>; Tue, 29 Nov 2022 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiK2T6m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Nov 2022 14:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiK2T6l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Nov 2022 14:58:41 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928727B23
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669751920; x=1701287920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9mbqdp9hpn1LeykbX4gLaUBDs/wJs1CqmMtHBoaePYU=;
  b=nYJfkNOhKe54VwuTNJFCIQOaXXo40sMx6XijSUCdxVA16xd2vSIQ86sl
   77tkXOXVT0zXRAywsnj341ITT1iucU7OcH780ZkStF4Wi+sSB90eLnD9D
   o1OMAp6FrbWpsW7Sxvkt1SNsmCi8IToyrDeN39DmLlOQCNFvkbxZY8U/J
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2022 11:58:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 11:58:35 -0800
Received: from qc-i7.hemma.eciton.net (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 29 Nov 2022 11:58:33 -0800
Date:   Tue, 29 Nov 2022 19:58:31 +0000
From:   Leif Lindholm <quic_llindhol@quicinc.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <grub-devel@gnu.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 0/2] efi: Add generic magic number in header
Message-ID: <Y4ZkZ0KmtjuV/cUQ@qc-i7.hemma.eciton.net>
References: <20221129175616.2089294-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221129175616.2089294-1-ardb@kernel.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 29, 2022 at 18:56:14 +0100, Ard Biesheuvel wrote:
> This is a minimal respin of the RFC patch I sent out a few week ago. No
> changes were applied except the /0x30/0x38 typo fix and some additional
> wording in the commit log. I also added a patch to make the command line
> initrd loader always built-in.
> 
> The purpose of all of this is to create *and document* a common baseline
> for EFI booting of Linux. (I know I promised some documentation myself,
> but I simply don't have time for that, so if anyone feels so inclined,
> please go ahead).
> 
> The idea is that EFI images with the LINUX_PE_MAGIC number are
> guaranteed to support:
> - initrd loading via LoadFile2
> - initrd loading via the command line
> - (on x86) mixed mode boot via the .compat entry point
> - other things I missed?
> 
> Architectures such as arm64 and RISC-V already have their own magic
> numbers, in which case the PE/COFF major/minor image version should be
> inspected, where 1.1 corresponds with the set described above.
> 
> If other architectures want to create hybrid images as well, it would be
> better to use a different offset to store the magic number, so that the
> generic EFI one can be carried as well. The reason for deviating from
> this for arm64 and RISC-V is the simple fact that existing images
> already exist, so for those architectures, we have to consider both
> anyway.
> 
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Leif Lindholm <quic_llindhol@quicinc.com>

For the series:
Acked-by: Leif Lindholm <quic_llindhol@quicinc.com>

Thanks!

> 
> Ard Biesheuvel (2):
>   efi: libstub: Always enable initrd command line loader and bump
>     version
>   efi: Put Linux specific magic number in the DOS header
> 
>  arch/loongarch/kernel/head.S                   |  3 ++-
>  arch/x86/boot/header.S                         |  3 ++-
>  drivers/firmware/efi/Kconfig                   | 15 ---------------
>  drivers/firmware/efi/libstub/efi-stub-helper.c |  3 +--
>  drivers/firmware/efi/libstub/zboot-header.S    |  3 ++-
>  include/linux/pe.h                             |  9 ++++++++-
>  6 files changed, 15 insertions(+), 21 deletions(-)
> 
> -- 
> 2.35.1
> 
