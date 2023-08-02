Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C476CF5E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjHBN7X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHBN7W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 09:59:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EFE4E;
        Wed,  2 Aug 2023 06:59:20 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D4711EC00F8;
        Wed,  2 Aug 2023 15:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690984758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QOfMj0yRD5e1Y7ZVsdyLC7SaQJiL2vnicxgkKfeEGcQ=;
        b=CZ4qmkgRU9PIcQ/ZHTBvKpUITHvq9JLZlUXNpJ77g0HP2KcNvFSAQogIGCmbfIa87ckwRl
        dbGLvvn5G4buwri1WDHhX1UoMeTNn626H+mR3exJU2Mnn1DmT/QY9R8YwIjnr8RfBXHc4E
        A0x6kBqAs5pVZZcIrnH5BpuBzNPDBX0=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VfcAOxr6NmCU; Wed,  2 Aug 2023 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690984755; bh=QOfMj0yRD5e1Y7ZVsdyLC7SaQJiL2vnicxgkKfeEGcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkvRJ2vbdyXkzctAg2muud/4V82jYKu05V31/emaUcJHnutqPYhNBIBnBZW3dJU/D
         bPH04+DeWXZ6PWwop0MwFMl+gUYDUOEfA7GlcmAWvpqqOi8yKykEDgVnBl+gOl3G28
         B0Ko7Wg/H0L/54XMBXt+0UuDWGRR8OBRz+vwOOoPAlOG6gUrXX9/hRemT7fX5hXzpW
         AhhGtQdTXToPEJc5LL9Br4YBLmN0oPsmU7EEgQBr+nQj1wzdR3tr27xtDUAtkU2NmU
         ks5TzoifyTSrgzzU0Q6Sb53hIrn7i0kuBZPWWDRa6l65Bsinobp0YNfNvxvr41eMER
         MHKStL8GhuJzpOMpnxsTy5QlDj9sqa1a/KbgSH8VSaQs72WPTAGyxHm2o+eJO/3mkJ
         8H8ZXUYpiLxYz7Vgwp2UdCiTwvkROLZw1XrejBizpVjSc6KxSKQ6RuDBVZWVFVmevL
         DNZcQj4Jps0u0cc4E9WP7fZe0pA8KQMx8MCY8F8k4R0E3PBpJ1K+WHIyBhcNn+h39U
         VqsdRdu0XVbD0eRvGRG/WB7v3GLkAkYsgIKnmSX3pvPPBtMIlMp3Fr0Lv8RO/Csv+0
         vjR9ftMwi5lHmlH5CbtV8gpmMgx3qnKGFQJ5fXUwKraef1yKsourdr5T7ZBHtySydJ
         54sKXze/yrrfurrD0CORuS54=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D58640E01FF;
        Wed,  2 Aug 2023 13:59:01 +0000 (UTC)
Date:   Wed, 2 Aug 2023 15:58:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Tao Liu <ltao@redhat.com>, Michael Roth <michael.roth@amd.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 02, 2023 at 08:40:36AM -0500, Tom Lendacky wrote:
> Short of figuring out how to map page accesses earlier through the
> boot_page_fault IDT routine

And you want to do that because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
