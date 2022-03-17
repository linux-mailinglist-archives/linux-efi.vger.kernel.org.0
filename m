Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2A4DC745
	for <lists+linux-efi@lfdr.de>; Thu, 17 Mar 2022 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiCQNMs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Mar 2022 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCQNMs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Mar 2022 09:12:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FA5189A01;
        Thu, 17 Mar 2022 06:11:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DE9A1F38D;
        Thu, 17 Mar 2022 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647522690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvO+RA/zs1DpQeEsRi/ZP4j6ZeSIQjHSJwuJ153Rf3w=;
        b=jGpIYhyXi/D9eAEdLR8J7hITGu1XjTKfh+W1wVTZTt58Hp/BmrWlh4q2KnJRmyGRa/I9SU
        vJgvTUNvAXvTMDkcBbG8Bys2iZ5qldetivZkYcqf3efpIGwGudGjOH3aRLThvvX3p/fqGF
        nI/W/9Wr+0/XSVgPMW1P6lyBOe7aw9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647522690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvO+RA/zs1DpQeEsRi/ZP4j6ZeSIQjHSJwuJ153Rf3w=;
        b=iEDCfo3fck1MScC4WHdS0jyL0VazxFMLAuGLLqw6FpaDjwTYrd852IK3+UvuHO6nraQ+DY
        aF3Fl+w78/gOF1BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ED5313B64;
        Thu, 17 Mar 2022 13:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EoYKE4IzM2I+CAAAMHmgww
        (envelope-from <bp@suse.de>); Thu, 17 Mar 2022 13:11:30 +0000
Date:   Thu, 17 Mar 2022 13:11:27 +0000
From:   Boris Petkov <bp@suse.de>
To:     Peter Gonda <pgonda@google.com>, Joerg Roedel <jroedel@suse.de>
CC:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>, linux-efi@vger.kernel.org,
        linux-coco@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
        Jim Mattson <jmattson@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, brijesh.ksingh@gmail.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marc Orr <marcorr@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v12_32/46=5D_x86/compressed/64=3A_Add_s?= =?US-ASCII?Q?upport_for_SEV-SNP_CPUID_table_in_=23VC_handlers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMkAt6r==_=U4Ha6ZTmii-JL3htJ3-dD4tc+QBqN7dVt711N2A@mail.gmail.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com> <20220307213356.2797205-33-brijesh.singh@amd.com> <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com> <20220310212504.2kt6sidexljh2s6p@amd.com> <YiuBqZnjEUyMfBMu@suse.de> <CAMkAt6r==_=U4Ha6ZTmii-JL3htJ3-dD4tc+QBqN7dVt711N2A@mail.gmail.com>
Message-ID: <23728EEA-37B8-478E-9576-DBFD6FE2A294@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On March 14, 2022 5:34:42 PM UTC, Peter Gonda <pgonda@google=2Ecom> wrote:
>I was also thinking about adding a vcpu run exit reason for
>termination=2E It would be nice to get a more informative exit reason
>than -EINVAL in userspace=2E Thoughts?

Absolutely - it should be unambiguously clear why we're terminating=2E=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
