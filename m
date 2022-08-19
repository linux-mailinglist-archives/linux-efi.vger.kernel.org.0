Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6359A417
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbiHSSB6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351930AbiHSSA4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 14:00:56 -0400
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 10:48:08 PDT
Received: from dibed.net-space.pl (dibed.net-space.pl [84.10.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD2459B0
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 10:48:08 -0700 (PDT)
Received: from router-fw.i.net-space.pl ([192.168.52.1]:36524 "EHLO
        tomti.i.net-space.pl") by router-fw-old.i.net-space.pl with ESMTP
        id S2155435AbiHSRSp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 19 Aug 2022 19:18:45 +0200
X-Comment: RFC 2476 MSA function at dibed.net-space.pl logged sender identity as: dkiper
Date:   Fri, 19 Aug 2022 19:18:42 +0200
From:   Daniel Kiper <dkiper@net-space.pl>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     grub-devel@gnu.org, daniel.kiper@oracle.com,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH] arm64/linux: Remove magic number header field check
Message-ID: <20220819171842.fhhyevkfvwjtcpkj@tomti.i.net-space.pl>
References: <20220811145157.3237840-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811145157.3237840-1-ardb@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 11, 2022 at 04:51:57PM +0200, Ard Biesheuvel wrote:
> The 'ARM\x64' magic number in the file header identifies an image as one
> that implements the bare metal boot protocol, allowing the loader to
> simply move the file to a suitably aligned address in memory, with
> sufficient headroom for the trailing .bss segment (the required memory
> size is described in the header as well).
>
> Note of this matters for GRUB, as it only supports EFI boot. EFI does
> not care about this magic number, and nor should GRUB: this prevents us
> from booting other PE linux images, such as the generic EFI zboot
> decompressor, which is a pure PE/COFF image, and does not implement the
> bare metal boot protocol.
>
> So drop the magic number check.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel
