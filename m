Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E314F8216
	for <lists+linux-efi@lfdr.de>; Thu,  7 Apr 2022 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbiDGOtm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Apr 2022 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiDGOtl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Apr 2022 10:49:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D501B3DFE;
        Thu,  7 Apr 2022 07:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43689212CA;
        Thu,  7 Apr 2022 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649342858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEpOOttjvoUOVasmXAsJpY6Q5iNZbgHNH+XLnQf/mr0=;
        b=mn3LNRAvq1DPia5c5FhuVf/A2AGoYxSlFq/woldm/j5+8408QUkjCb1rmYaGqfI/hTv+oD
        e6BAwOJ8bfshnxTA67lerKJ8kIijBQc01D0HPph+lHYRPjBfmpthPdgMdBKmnGlWyGGV67
        awYGzqweZ/Lv2P2fPvVfVD5Nq8w4WSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649342858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEpOOttjvoUOVasmXAsJpY6Q5iNZbgHNH+XLnQf/mr0=;
        b=CtvFw589hGQJBghYO6rW1rTfOAhb69sM87A0i3sS1K3CJVWP1zZfmiBnNsP/Ie5XD+Nme3
        +f379Iw8YGylT5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3258713485;
        Thu,  7 Apr 2022 14:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f3FBDIr5TmJaXAAAMHmgww
        (envelope-from <bp@suse.de>); Thu, 07 Apr 2022 14:47:38 +0000
Date:   Thu, 7 Apr 2022 16:47:36 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 29/46] x86/boot: Add Confidential Computing type to
 setup_data
Message-ID: <Yk75iF82rMdGHq7W@zn.tnic>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-30-brijesh.singh@amd.com>
 <87v8vlzz8x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v8vlzz8x.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 06, 2022 at 11:19:10PM +0200, Thomas Gleixner wrote:
> On Mon, Mar 07 2022 at 15:33, Brijesh Singh wrote:
> >  
> > +/*
> > + * AMD SEV Confidential computing blob structure. The structure is
> > + * defined in OVMF UEFI firmware header:
> > + * https://github.com/tianocore/edk2/blob/master/OvmfPkg/Include/Guid/ConfidentialComputingSevSnpBlob.h
> > + */
> > +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
> > +struct cc_blob_sev_info {
> > +	u32 magic;
> > +	u16 version;
> > +	u16 reserved;
> > +	u64 secrets_phys;
> > +	u32 secrets_len;
> > +	u32 rsvd1;
> > +	u64 cpuid_phys;
> > +	u32 cpuid_len;
> > +	u32 rsvd2;
> > +};
> 
> Shouldn't this be packed?

Done.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
