Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1159870BFDB
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjEVNfK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjEVNfJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 09:35:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD7B3;
        Mon, 22 May 2023 06:35:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 046161FF22;
        Mon, 22 May 2023 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684762507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwgZPSVQU88xY0ZuspB0YnyfVDoSsMQeh+w6yWQbG00=;
        b=V11m+XimLIAJUvZk+8dpYiYuCMTXNW23lbOGhoW3+FIfNNTqjQmH7adJtuLANzfrhW/lpN
        khCq8DgNcGnBtllWaMw5B0WaGdz5/zvkn4+HIJvglTRLAPpXeR31z2RQfyY/TG8sXGJHek
        TdtiDK7w7b+Y3Tns3X7cO7vi9jmsUzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684762507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwgZPSVQU88xY0ZuspB0YnyfVDoSsMQeh+w6yWQbG00=;
        b=i722WT24nV5NvTt1wzMBdAxalDnA6FboXuj30errRw45wTfx3Rdq8MPdRaRX6FPtr6JKvI
        JaijZ7Xa/f41YpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7369613336;
        Mon, 22 May 2023 13:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RJmjGopva2Q/fwAAMHmgww
        (envelope-from <jroedel@suse.de>); Mon, 22 May 2023 13:35:06 +0000
Date:   Mon, 22 May 2023 15:35:05 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while
 running in the firmware
Message-ID: <ZGtviWSsRe4wG1aQ@suse.de>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-18-ardb@kernel.org>
 <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com>
 <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
 <b6192de1-26a4-a7a7-63bf-76c36f55a8ff@amd.com>
 <ZGtkrKhxqUiTlXY0@suse.de>
 <CAMj1kXEQ-hv8ZAtoFwqN9DYYjSnkXaaMrOuXsL5_92M3E6gdHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEQ-hv8ZAtoFwqN9DYYjSnkXaaMrOuXsL5_92M3E6gdHQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 22, 2023 at 03:07:12PM +0200, Ard Biesheuvel wrote:
> So IIUC, we could just read sev_status much earlier just to perform
> the SNP feature check, and fail the boot gracefully on a mismatch. And
> the sev_enable() call needs to move after ExitBootServices(), right?

Right, sev_enable() negotiates the GHCB protocol version, which needs
the GHCB MSR, so that has to stay after ExitBootServices(). The
SEV feature check on the other side only needs to read the sev-status
MSR, which is no problem before ExitBootServices() (as long as it is
only read on SEV platforms).

> That would result in only very minor duplication, afaict. I'll have a
> stab at implementing this for v4.

Thanks,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

