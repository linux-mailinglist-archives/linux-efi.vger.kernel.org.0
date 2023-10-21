Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69B7D19D1
	for <lists+linux-efi@lfdr.de>; Sat, 21 Oct 2023 02:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJUAIF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Oct 2023 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJUAIE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Oct 2023 20:08:04 -0400
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DF1D71;
        Fri, 20 Oct 2023 17:07:59 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id CFD011060170;
        Sat, 21 Oct 2023 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1697846876;
        s=s1; d=bens.haus;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=Sw9x7wuuA1QNrztZOrHa/S9dqjr9j06JtwY8MvJxGR0=;
        b=U4ruX1LaDK1WgzzvxwkFPrvUBJ2D5dKO0dBUlsQDA+z18DRSLkDdv20fDvBFYkpn
        wJK+8iaTVlga43jzXy62RzAx4snpdvcSGHtdN3dEi5s8LebtQ/NAtFjQSeCHtbA7klj
        a/TIC00+68zOrXZCs2oCgkra4nFPbecTpoXHhycrqmXLi1LOcJM494PY48fb3rFd2FT
        3U285vwOHf5hJLAOSkmLYcxrJW6x07rUm+zDWUeMSCKI7Yze7zTcl79eyCugnA1SiE0
        RRGqJ9CxBD93xsKidaCH99TkiL/Lia51vCaeErE3cOF3Sy0F7MEiCzYwvuzhSxg5B//
        ZIR6USBkHw==
Date:   Sat, 21 Oct 2023 02:07:56 +0200 (CEST)
From:   Ben Schneider <ben@bens.haus>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <NhEYpWg--3-9@bens.haus>
In-Reply-To: <Nh8pThy--3-9@bens.haus>
References: <Nh-DzlX--3-9@bens.haus> <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com> <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com> <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com> <Nh30qsF--3-9@bens.haus> <57062702-f858-46d3-bccc-f0f96891128b@canonical.com> <Nh8pThy--3-9@bens.haus>
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Oct 20, 2023, 01:25 by ben@bens.haus:

> Oct 19, 2023, 07:21 by heinrich.schuchardt@canonical.com:
>
>> Compiling upstream U-Boot's qemu_arm64_defconfig yields lib/efi_loader/dtbdump.efi. If you run this instead of the kernel, you can write the device-tree as it is passed in a configuration table to the ESP.
>>
> I compiled and ran this fine, but I was unable to save the device tree. I suspect this is because the program searches for an ESP, and there is none on the device. U-boot was compiled with support to load directly from an ext4 filesystem so I didn't bother setting one up. I will work on it. 
>
Hi Heinrich, I loaded dtbdump.efi from a FAT32 formatted partition with type EFI System, but attempts to run the save command return "Failed to open simple file system protocol". Sorry if there is something else I am missing.

Ben
