Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9A61F894
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 17:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiKGQMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 11:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiKGQMc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 11:12:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614B2037C
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 08:12:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16412B8136A
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BB9C433D6;
        Mon,  7 Nov 2022 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667837548;
        bh=QC6jwXB7pZSFZiayacrdUHtw3C127MJmlDzPPTXyZfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hs0b4M5EJhQXLHD6rRSaZuBr73/R8D+9qglQnkcIFK69fzcqEnCJ+v1Zw/4YthjjW
         A9m4oHQM55njxMimKwLaDUe/b0rP+P8NfOv1i0Kn4U2X/ez3K4UJ/EXj/rqi2d5D/H
         j3CXiHY3QJdcEI08xDeiLbPxlBgvDTJpvvW5wnxbP9r8vSY2yOg+Tdl0AXLB8COFYE
         i+pAke+Z3nypZ1yY/D5DgQmGoVdSs+zFd1KLhDqJ3IDri5Jkm/eUSlL23v8UKIueub
         Y07au9qSgX3Bwv7vCpz1+LiprbDmb6tjCSIzJeE3i8XZUP/eLoUJsUYK0xWh8E9KWp
         07Fjhl94sV1qA==
Date:   Mon, 7 Nov 2022 16:12:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 0/6] arm64: efi: leave MMU and caches on at boot
Message-ID: <20221107161222.GE21157@willie-the-truck>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Tue, Oct 18, 2022 at 01:04:35PM +0200, Ard Biesheuvel wrote:
> The purpose of this series is to remove any explicit cache maintenance
> for coherency during early boot that becomes unnecessary if we simply
> retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> and use it to populate the ID map page tables. After setting up this
> preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> TCR and SCTLR registers as before, and proceed as usual, avoiding the
> need for any manipulations of memory while the MMU and caches are off.
> 
> The only properties of the firmware provided 1:1 map we rely on is that
> it does not require any explicit cache maintenance for coherency, and
> that it covers the entire memory footprint of the image, including the
> BSS and padding at the end - all else is under control of the kernel
> itself, as before.
> 
> Changes since v3:
> - drop EFI_LOADER_CODE memory type patch that has been queued in the
>   mean time
> - rebased onto [partial] series that moves efi-entry.S into the libstub/
>   source directory [0]
> - fixed a correctness issue in patch #2

I really like this series, but I'm also very nervous about supporting
booting the kernel with the MMU enabled outside of EFI. The booting
documentation prohibits this, but we don't appear to take any steps to
prevent this case with your series. Perhaps we shouldn't, but I do think
it would be worth trying to warn+taint if we detect it so that we don't
spend too much time debugging strange memory issues on platforms that
try to use such a configuration.

What do you think?

Cheers,

Will
