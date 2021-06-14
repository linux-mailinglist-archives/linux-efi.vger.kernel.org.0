Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E53A6CDD
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jun 2021 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhFNRRc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Jun 2021 13:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233206AbhFNRRb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Jun 2021 13:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623690927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+gTijY/9FvVzLFpGxKknxMCcEc6fcclmIjEJe/DmWM=;
        b=ZCJ1PHVK/4ybw5BjL9Q5lkL0TtRWD+MOnNQvea0JnkeVqjqCShFC/vnKAwpzz6S7Y85lUD
        B2AhLs4jup/3RnS+SpYZGsb86e83Q9NsDCj9Bg27PdrKh/8GpRhQS63sdcIEDXGh26kFPY
        ET9fq4cSnqf7Zx1mgcrJ7EBmqpgAgsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-8P8sYQ2cMfCzk8w2c626Cg-1; Mon, 14 Jun 2021 13:15:26 -0400
X-MC-Unique: 8P8sYQ2cMfCzk8w2c626Cg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E498015A4;
        Mon, 14 Jun 2021 17:15:23 +0000 (UTC)
Received: from work-vm (ovpn-114-158.ams2.redhat.com [10.36.114.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 398B95D9CA;
        Mon, 14 Jun 2021 17:15:11 +0000 (UTC)
Date:   Mon, 14 Jun 2021 18:15:08 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
Message-ID: <YMeOnO4PBnvxEQEv@work-vm>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com>
 <YMEVedGOrYgI1Klc@work-vm>
 <8a598020-7d89-b399-efb9-735b2a6da8a9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a598020-7d89-b399-efb9-735b2a6da8a9@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Tom Lendacky (thomas.lendacky@amd.com) wrote:
> On 6/9/21 2:24 PM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >> Version 2 of GHCB specification provides NAEs that can be used by the SNP
> >> guest to communicate with the PSP without risk from a malicious hypervisor
> >> who wishes to read, alter, drop or replay the messages sent.
> >>
> >> The hypervisor uses the SNP_GUEST_REQUEST command interface provided by
> >> the SEV-SNP firmware to forward the guest messages to the PSP.
> >>
> >> In order to communicate with the PSP, the guest need to locate the secrets
> >> page inserted by the hypervisor during the SEV-SNP guest launch. The
> >> secrets page contains the communication keys used to send and receive the
> >> encrypted messages between the guest and the PSP.
> >>
> >> The secrets page is located either through the setup_data cc_blob_address
> >> or EFI configuration table.
> >>
> >> Create a platform device that the SNP guest driver can bind to get the
> >> platform resources. The SNP guest driver can provide userspace interface
> >> to get the attestation report, key derivation etc.
> >>
> >> The helper snp_issue_guest_request() will be used by the drivers to
> >> send the guest message request to the hypervisor. The guest message header
> >> contains a message count. The message count is used in the IV. The
> >> firmware increments the message count by 1, and expects that next message
> >> will be using the incremented count.
> >>
> >> The helper snp_msg_seqno() will be used by driver to get and message
> >> sequence counter, and it will be automatically incremented by the
> >> snp_issue_guest_request(). The incremented value is be saved in the
> >> secrets page so that the kexec'ed kernel knows from where to begin.
> >>
> >> See SEV-SNP and GHCB spec for more details.
> >>
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >> ---
> >>  arch/x86/include/asm/sev.h      |  12 +++
> >>  arch/x86/include/uapi/asm/svm.h |   2 +
> >>  arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
> >>  arch/x86/platform/efi/efi.c     |   2 +
> >>  include/linux/efi.h             |   1 +
> >>  include/linux/sev-guest.h       |  76 ++++++++++++++
> >>  6 files changed, 269 insertions(+)
> >>  create mode 100644 include/linux/sev-guest.h
> >>
> 
> >> +u64 snp_msg_seqno(void)
> >> +{
> >> +	struct snp_secrets_page_layout *layout;
> >> +	u64 count;
> >> +
> >> +	layout = snp_map_secrets_page();
> >> +	if (layout == NULL)
> >> +		return 0;
> >> +
> >> +	/* Read the current message sequence counter from secrets pages */
> >> +	count = readl(&layout->os_area.msg_seqno_0);
> > 
> > Why is this seqno_0 - is that because it's the count of talking to the
> > PSP?
> 
> Yes, the sequence number is an ever increasing value that is used in
> communicating with the PSP. The PSP maintains the next expected sequence
> number and will reject messages which have a sequence number that is not
> in sync with the PSP. The 0 refers to the VMPL level. Each VMPL level has
> its own sequence number.

Can you just clarify; is that the VMPL of the caller or the destination?
What I'm partially asking here is whether it matters which VMPL the
kernel is running at (which I'm assuming could well be non-0)

> > 
> >> +	iounmap(layout);
> >> +
> >> +	/*
> >> +	 * The message sequence counter for the SNP guest request is a 64-bit value
> >> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
> >> +	 * it.
> >> +	 */
> >> +	if ((count + 1) >= INT_MAX)
> >> +		return 0;
> > 
> > Is that UINT_MAX?
> > 
> >> +
> >> +	return count + 1;
> >> +}
> >> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
> >> +
> >> +static void snp_gen_msg_seqno(void)
> >> +{
> >> +	struct snp_secrets_page_layout *layout;
> >> +	u64 count;
> >> +
> >> +	layout = snp_map_secrets_page();
> >> +	if (layout == NULL)
> >> +		return;
> >> +
> >> +	/* Increment the sequence counter by 2 and save in secrets page. */
> >> +	count = readl(&layout->os_area.msg_seqno_0);
> >> +	count += 2;
> > 
> > Why 2 not 1 ?
> 
> The return message by the PSP also increments the sequence number, hence
> the increment by 2 instead of 1 for the next message to be submitted.

OK

Dave

> I'll let Brijesh address the other questions.
> 
> Thanks,
> Tom
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

