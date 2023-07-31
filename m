Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42978769414
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGaLCD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGaLCD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 07:02:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3EF123;
        Mon, 31 Jul 2023 04:01:58 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E677A1EC05B8;
        Mon, 31 Jul 2023 13:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690801316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nlsmpofw6DIwO7IjZ/iWNu8BpAauoRxQAhPjqVl0FWQ=;
        b=YWaTwVv+ZcZsP6E+yz4wJu0whz6LS1dEtUfGoYxFCJaWXhkoyVQmCnGCXwdiO5OC+OI5GY
        hYNS3UZ+TRa3D2nZvyu9ucAJ+gbcRRdkkgODofZaNu8J6xNeq2xInPcoj1uXUEMTiexlQZ
        qzYUir0v4fTNUGbZlvilErZI96wSp9c=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Wh-GnaPGP5uW; Mon, 31 Jul 2023 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690801314; bh=nlsmpofw6DIwO7IjZ/iWNu8BpAauoRxQAhPjqVl0FWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GD6WLUYqLyASsfD9cPb5HoH0zUhgdSHuAsOVVQ7FbnTDR78xk5esdD179B3FgEg6z
         xdVTOYM2JdUulocntMXYpMz3R5ybCBo+sjIFIip5lbZ1thItZgDuG+220Uywcu6pYh
         HWYbhFkB+cbTe0x3fZeaINPKnwxmTbadDt7yQh9tIkL8CHat0/aZyEFU+ksXM/goWI
         Yvw7XCMDoPnqDRQfi+iYKzY2VgUd1ci8LVPPAuH70bRswUXi0TOq9B+qxYoukb7bF9
         qiWERSQnsmDiraas0edUNwM3FDD+tW7/Lz/XX5A9OX0nPRw0WEv2SAX+G1dCie1ZCl
         tSrXgxeQrYt/vsSF+8HVHFNY/GCWZTgvhg6qrrN+pfF6VWBvV//xXADa8eWYq91eLj
         whML21WBzbGy/MsEqdMm/tWmBuKtvITD1b6g1GOThak9wXxSxIs7cBSrFjLTVU+x6S
         a01dt0aeRmkMznJxZKEGKhSeGM653RvoR58IvM0RZNfgPZQCQgeNvI13XxW73ffsbz
         9GYuHDPZPUP/TwmRkwsgFSPgCnDvDiYxRJ0Ou97+CLokfXrExkQye18itNNDJl9XtA
         1z+v/c5qgJkSJPcdN8TM2gMAlfcTuEA9HDUZl4ekVIVgGdqhmKnKZ6y8s/2y1EMeJo
         ZQtaJHuGojUYOYAVxp+s5ygk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DB7F40E01CE;
        Mon, 31 Jul 2023 11:01:35 +0000 (UTC)
Date:   Mon, 31 Jul 2023 13:01:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v7 01/22] x86/decompressor: Don't rely on upper 32 bits
 of GPRs being preserved
Message-ID: <20230731110129.GBZMeUiQivh9fRvXSu@fat_crate.local>
References: <20230728090916.1538550-1-ardb@kernel.org>
 <20230728090916.1538550-2-ardb@kernel.org>
 <20230731100713.GAZMeH0RvXfNclFqMO@fat_crate.local>
 <CAMj1kXHOsAHPMSSAdGKR22-uN-jki7y5TcQOJ4GLue1z1kbtuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHOsAHPMSSAdGKR22-uN-jki7y5TcQOJ4GLue1z1kbtuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 31, 2023 at 12:09:04PM +0200, Ard Biesheuvel wrote:
> This is already fixed further down in the series.

Thanks, lemme look.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
