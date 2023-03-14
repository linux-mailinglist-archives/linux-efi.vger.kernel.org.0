Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC76BA0D0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 21:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCNUeE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNUeD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 16:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392D3B210;
        Tue, 14 Mar 2023 13:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D6B61994;
        Tue, 14 Mar 2023 20:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593FDC4339B;
        Tue, 14 Mar 2023 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678826025;
        bh=iN04j8aiExsMR4SAjvFhCPSopIclwuHB2+vsqetGB2o=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=EqkjMMufTXpVwvKOtms63LFXnEXRSuVovPNXl9WsIfWdp1iS4w9LrKotvYvQH0eRo
         Bcxiu1jOqjqzk8OOiy2hZIHy4cMu8OJURLa6jcM8fUMG+V2kCLDEcDM5SYmsVWzRGr
         /fB4ZEUDTWhVeZjkYj9w7ZmnsFHLj8RerHum/1Ee3GimVfxfTqOJnkiuxY0nLBcijr
         jYXIYjerGE2QsiwbAC/mh6Xvr6Qqs/MkRh2Kmv1fOYM1ayPhMau+i2u3t1fJ0TCUBU
         rHT0AaVLNVtqRDZxt/Vz00JhhfE6lIOi1r/AL695KyiqoCUaHRdL6h19a7nK4WOi3T
         M2R8aiDPd/r6A==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 31C8927C005B;
        Tue, 14 Mar 2023 16:33:44 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 14 Mar 2023 16:33:44 -0400
X-ME-Sender: <xms:JtoQZG5uOVBLkLKF3AJD5CjbZcLpQr_Dz0_-Z5YALn8JhNSaRHahSA>
    <xme:JtoQZP70CDtvpMBcGxIVjvPK-73pk0c2Fw-b3bnZbfOVDgy6LmQAjXF3ErIxy7fww
    z_XBH3KrEQqNDsFhN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:JtoQZFfcdERFCZZYFeF32HRrnG5L4vAKMRA5fPY4VIqGmajLXS5iig>
    <xmx:JtoQZDJnz_pPFc9ODWmrbyegUA5LHhdUf8_jG6uvVKPiRroBY0sO6g>
    <xmx:JtoQZKKgYduelpNdf-ukaN6WctAta7EXcZoVup0zx8joP4D2MisShw>
    <xmx:KNoQZMjJELIj5Z6R8tmgCmH5saqssxNtLVXlDwuDI1gg6Lxg5vhNng>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CCAA31A0063; Tue, 14 Mar 2023 16:33:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <259a1148-faf0-4765-b777-6f36459c9307@app.fastmail.com>
In-Reply-To: <dab948690a74db1bb75d95aa7e0362deeca6dbf4.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
 <dab948690a74db1bb75d95aa7e0362deeca6dbf4.1678785672.git.baskov@ispras.ru>
Date:   Tue, 14 Mar 2023 13:33:21 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Evgeniy Baskov" <baskov@ispras.ru>,
        "Ard Biesheuvel" <ardb@kernel.org>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Peter Jones" <pjones@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 09/27] x86/boot: Remove mapping from page fault handler
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
> After every implicit mapping is removed, this code is no longer needed.
>
> Remove memory mapping from page fault handler to ensure that there are
> no hidden invalid memory accesses.

This patch is *by far* the scariest of the bunch in my boot.  And it violates a basic principle of kernel development: it's better to run in degraded mode than to fail outright unless running in degraded mode is dangerous for some reason.

And this boot code is not actually meaningfully exposed to attack.  Anyone who can get the boot code to consume garbage likely *already* controls the system, including anything that we might write to TPM or any other verification mechanism.

So I think this should log an error, set a flag to make sure we print an even louder error after full boot, but still add the mapping and keep trying.

--Andy

>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++---------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/ident_map_64.c 
> b/arch/x86/boot/compressed/ident_map_64.c
> index eb28ce9812c5..378f99b1d7e8 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -393,27 +393,21 @@ void do_boot_page_fault(struct pt_regs *regs, 
> unsigned long error_code)
>  {
>  	unsigned long address = native_read_cr2();
>  	unsigned long end;
> -	bool ghcb_fault;
> +	char *msg;
> 
> -	ghcb_fault = sev_es_check_ghcb_fault(address);
> +	if (sev_es_check_ghcb_fault(address))
> +		msg = "Page-fault on GHCB page:";
> +	else
> +		msg = "Unexpected page-fault:";
> 
>  	address   &= PMD_MASK;
>  	end        = address + PMD_SIZE;
> 
>  	/*
> -	 * Check for unexpected error codes. Unexpected are:
> -	 *	- Faults on present pages
> -	 *	- User faults
> -	 *	- Reserved bits set
> -	 */
> -	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
> -		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
> -	else if (ghcb_fault)
> -		do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
> -
> -	/*
> -	 * Error code is sane - now identity map the 2M region around
> -	 * the faulting address.
> +	 * Since all memory allocations are made explicit
> +	 * now, every page fault at this stage is an
> +	 * error and the error handler is there only
> +	 * for debug purposes.
>  	 */
> -	kernel_add_identity_map(address, end, MAP_WRITE);
> +	do_pf_error(msg, error_code, address, regs->ip);
>  }
> -- 
> 2.39.2
