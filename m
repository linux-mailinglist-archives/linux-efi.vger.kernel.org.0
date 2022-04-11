Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84B04FC6CE
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbiDKVha (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiDKVh3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 17:37:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CD32EC3;
        Mon, 11 Apr 2022 14:35:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 933201F38D;
        Mon, 11 Apr 2022 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649712911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3uWqyQeh3AA+Cb46dnWvEZ3Eid4YgcxD15T0bs7OF0=;
        b=x0Y0t9ignpUl5ppfhCGjNNVzR3W2LNG7TIA+jRNvkPwW6FTlHMpmEZLNyHfBvuN9wvLliT
        vyRlXNTDtCCF8OPpwP/+cQ9Ww6cPwV0gOWqNSHFD84Rsti9dz5v3NpljGwbfNCxlDxCvJ8
        FVKPDKp/Od3Pfp13LahQTCoMntoEjVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649712911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3uWqyQeh3AA+Cb46dnWvEZ3Eid4YgcxD15T0bs7OF0=;
        b=Og1/lO74QMsxltiaEGnXBQ3qTUSdssihtPWBqe7B1xPnv5j2TtvEoklcTp41wddCYhku+J
        u2AYR6PAxvbBUMAw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 93C70A3B83;
        Mon, 11 Apr 2022 21:35:10 +0000 (UTC)
Date:   Mon, 11 Apr 2022 23:35:09 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v10 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Message-ID: <20220411213509.GG163591@kunlun.suse.cz>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <20220126025834.255493-9-eric.snowberg@oracle.com>
 <20220411110640.GC163591@kunlun.suse.cz>
 <C970A5DB-0238-4B5A-9935-588DF9B1DDEF@oracle.com>
 <20220411172450.GD163591@kunlun.suse.cz>
 <54B1CDD9-F690-4F1F-9A9A-9412AAB21A72@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54B1CDD9-F690-4F1F-9A9A-9412AAB21A72@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 11, 2022 at 08:34:55PM +0000, Eric Snowberg wrote:
> 
> 
> > On Apr 11, 2022, at 11:24 AM, Michal Suchánek <msuchanek@suse.de> wrote:
> > 
> > On Mon, Apr 11, 2022 at 04:39:42PM +0000, Eric Snowberg wrote:
> >> 
> >> 
> >>> On Apr 11, 2022, at 5:06 AM, Michal Suchánek <msuchanek@suse.de> wrote:
> >>> 
> >>> Hello,
> >>> 
> >>> On Tue, Jan 25, 2022 at 09:58:34PM -0500, Eric Snowberg wrote:
> >>>> With the introduction of uefi_check_trust_mok_keys, it signifies the end-
> >>> 
> >>> What value does such flag have?
> >>> 
> >>> The user is as much in control of the flag as the MOK keys.
> >> 
> >> The flag allows the system owner (not root) the ability to determine 
> >> if they want to load MOKList into the machine keyring.  Keys contained 
> >> in the machine keyring are then linked to the secondary.  The flag is no 
> >> different than the '—ignore-db' currently available in shim, which then 
> >> gets propagated to Linux (uefi_check_ignore_db).  These flags can be 
> >> set by the system owner, who can prove physical presence.  
> > 
> > Managing the MOK keys requires physical presence equally.
> > 
> > Moreover, these keys are trusted for running code at ring0, in fact the
> > running kernel is expected to be signed by one of them, and can be
> > signed by any of them.
> > 
> > Then what exact purpose does this extra flag serve?
> > 
> > If such compile-time flag exists in the kernel it cannot be overriden by
> > the root once the kernel is signed, either.
> > 
> >>>> user wants to trust the machine keyring as trusted keys.  If they have
> >>>> chosen to trust the machine keyring, load the qualifying keys into it
> >>>> during boot, then link it to the secondary keyring .  If the user has not
> >>>> chosen to trust the machine keyring, it will be empty and not linked to
> >>>> the secondary keyring.
> >>> 
> >>> Why is importing the keys and using them linked together?
> >>> 
> >>> If later we get, say, machine keyring on powerpc managed by secvarctl
> >>> then it has its value to import the keyring and be able to list the
> >>> content with the same tools on EFI and powerpc.
> >> 
> >> The machine keyring is linked to the secondary keyring, exactly the same way 
> >> the builtin is linked to it.  Linking this way should eliminate the need to change 
> >> any user space tools to list the contents. 
> > 
> > That's answer to a completely different question, though.
> > 
> > You either import the keys and use them, or you don't use them and don't
> > import them. The option to import and not use is not available.
> 
> Why import something into a keyring that can not be used?
> 
> MOKList keys get imported into one of two keyrings, either the machine or the 
> platform.  If uefi_check_trust_mok_keys returns false, the MOKList keys are 
> loaded into the platform along with the UEFI SB DB keys.  If true, they are loaded 
> into the machine keyring.

Ooh, such quirky and convoluted design. Not sure how anyone is supposed
to make any sense of this but hey, none of this can possibly change to
not break something.

Now I at least know.

Thanks

Michal
