Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89B3DB7E4
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jul 2021 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhG3LbK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Jul 2021 07:31:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52158 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbhG3LbJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Jul 2021 07:31:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 771822232B;
        Fri, 30 Jul 2021 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627644663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i5/8P81wWKC2EpiUP3Ejs7q4Xz+ybvx8UrMU1RwVW8=;
        b=1FG7TknlogbuGPp4BV8k+OVpjRdWs6/5v+ZJjlXdVE5gwj2C9cp5faC+4VpbgtPWlat/MM
        VUKr1OKF/PgOmuuPuXlA+xJ+XkaUTE+bz1ATzIUWIUMAnD9WGrh2U042Dmaw5+f0pCwKgf
        5KYrqgQDu9YkmB6KYmh/9daaOeAhNuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627644663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i5/8P81wWKC2EpiUP3Ejs7q4Xz+ybvx8UrMU1RwVW8=;
        b=E6W9oaolIYJXsCXJWlD8cjTCtV5D8TbX4yudUeAx58zz5GaoZmkpGX2HAOjgxsWnoY19Lb
        QAATd1d6oY41C5AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0D9A7137C2;
        Fri, 30 Jul 2021 11:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id z+f8AffiA2FYRgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 30 Jul 2021 11:31:03 +0000
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when adding
 the page in RMP table
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Michael Roth <michael.roth@amd.com>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com> <YO9kP1v0TAFXISHD@google.com>
 <d486a008-8340-66b0-9667-11c8a50974e4@amd.com> <YPB1n0+G+0EoyEvE@google.com>
 <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com> <YPCA0A+Z3RKfdsa3@google.com>
 <8da808d6-162f-bbaf-fa15-683f8636694f@amd.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b6793038-c24b-a65b-1ca4-ed581b254ff4@suse.cz>
Date:   Fri, 30 Jul 2021 13:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8da808d6-162f-bbaf-fa15-683f8636694f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/15/21 9:38 PM, Brijesh Singh wrote:
> 
> 
> On 7/15/21 1:39 PM, Sean Christopherson wrote:
>> On Thu, Jul 15, 2021, Brijesh Singh wrote:
>>> The memfd_secrets uses the set_direct_map_{invalid,default}_noflush() and it
>>> is designed to remove/add the present bit in the direct map. We can't use
>>> them, because in our case the page may get accessed by the KVM (e.g
>>> kvm_guest_write, kvm_guest_map etc).
>>
>> But KVM should never access a guest private page, i.e. the direct map should
>> always be restored to PRESENT before KVM attempts to access the page.
>>
> 
> Yes, KVM should *never* access the guest private pages. So, we could potentially
> enhance the RMPUPDATE() to check for the assigned and act accordingly.

I think I'm not the first one suggesting it, but IMHO the best solution would be
to leave direct map alone (except maybe in some debugging/development mode where
you could do the unmapping to catch unexpected host accesses), and once there's
a situation with host accessing a shared page of the guest, it would temporarily
kmap() it outside of the direct map. Shouldn't these situations be rare enough,
and already recognizable due to the need to set up the page sharing in the first
place, that this approach would be feasible?

> Are you thinking something along the line of this:
> 
> int rmpupdate(struct page *page, struct rmpupdate *val)
> {
>     ...
>     
>     /*
>      * If page is getting assigned in the RMP entry then unmap
>      * it from the direct map before its added in the RMP table.
>      */
>     if (val.assigned)
>         set_direct_map_invalid_noflush(page_to_virt(page), 1);
> 
>     ...
> 
>     /*
>      * If the page is getting unassigned then restore the mapping
>      * in the direct map after its removed from the RMP table.
>      */
>     if (!val.assigned)
>         set_direct_map_default_noflush(page_to_virt(page), 1);
>     
>     ...
> }
> 
> thanks

