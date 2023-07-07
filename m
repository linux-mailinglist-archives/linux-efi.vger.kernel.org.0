Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47474ACCB
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGGIXH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjGGIXB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 04:23:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B6DD;
        Fri,  7 Jul 2023 01:23:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4702227B0;
        Fri,  7 Jul 2023 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688718178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTaTx/R0QAu6GJW6rE7C/1qQWY5Fc41FkF1jDqmTGVY=;
        b=aKFSdPYVU/8rW9N80UySni4O07Kx0AnMzhdVdu6NZat0CXnyicNGBh0pQ35tkiT+R3C/Gb
        GbKfjoEWjEfJAkHI/g1B/gl9Sz7Q2fbWtc2MK5JoHa4mBGzbIEw9cOtBUxmHDC3O+bFB50
        /SfLFPdBwGH/E4cuoBk9/yAih7SGX/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688718178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTaTx/R0QAu6GJW6rE7C/1qQWY5Fc41FkF1jDqmTGVY=;
        b=W3ApvboxU9JouxaEEKxMBuOkgOmRPL0CSDAdvIGYPnLG/UJpYFfjtQKjX2tQUrHrD9D4Ke
        d8zwq+IS+W5MfMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FA23139E0;
        Fri,  7 Jul 2023 08:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s/dbEmLLp2SiOgAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 07 Jul 2023 08:22:58 +0000
Date:   Fri, 7 Jul 2023 10:22:56 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
        Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, michael.roth@amd.com
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKfLYG_4DANc_i5r@suse.de>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> I am wondering why we don't detect the cpu type and return early inside
> sev_enable() if it's Intel cpu.
> 
> We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> executed or not because we usually enable them all in distros.

Looking at the code in head_64.S, by the time sev_enable() runs the SEV
bit should already be set in sev_status. Maybe use that to detect
whether SEV is enabled and bail out early?

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

