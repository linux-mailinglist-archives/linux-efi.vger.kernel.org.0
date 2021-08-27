Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B663F9F05
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhH0SlX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhH0SlX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Aug 2021 14:41:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09BC061757;
        Fri, 27 Aug 2021 11:40:34 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 842FF1EC0464;
        Fri, 27 Aug 2021 20:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630089628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NhP3vMH5lATgbr/qa6Fg8YH0/Kap+rPek8c5UwiIt8=;
        b=ddARyS0cWg2k1gFCk02lIWfxXSvg/bvocKhn2aoj0uhIEKswfLmKtKUr/LrzjXBR9PwvgR
        xfndRLWSkMJ8Dtk31vwwf0vbFZJ48Xgj7nNoDh8jnfp0gg9WIrGfx23FgS5+cjg5TzYOm+
        ELRKRVgcYHOyYv6Wzcftep4P2cXSTAI=
Date:   Fri, 27 Aug 2021 20:41:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
Message-ID: <YSkxxkVdupkyxAJi@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820151933.22401-35-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:29AM -0500, Brijesh Singh wrote:
> The SNP guest request message header contains a message count. The
> message count is used while building the IV. The PSP firmware increments
> the message count by 1, and expects that next message will be using the
> incremented count. The snp_msg_seqno() helper will be used by driver to
> get the message sequence counter used in the request message header,
> and it will be automatically incremented after the request is successful.
> The incremented value is saved in the secrets page so that the kexec'ed
> kernel knows from where to begin.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sev-guest.h | 37 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 319a40fc57ce..f42cd5a8e7bb 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>  

Explain what that is in a comment above it.

> +static u64 snp_secrets_phys;

snp_secrets_pa;

is the usual convention when a variable is supposed to contain a
physical address.

> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -2030,6 +2032,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  		halt();
>  }
>  
> +static struct snp_secrets_page_layout *snp_map_secrets_page(void)
> +{
> +	u16 __iomem *secrets;
> +
> +	if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
> +		return NULL;
> +
> +	secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
> +	if (!secrets)
> +		return NULL;
> +
> +	return (struct snp_secrets_page_layout *)secrets;
> +}

Or simply:

static struct snp_secrets_page_layout *map_secrets_page(void)
{
        if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
                return NULL;
                
        return ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
}

?

> +
> +static inline u64 snp_read_msg_seqno(void)

Drop that "snp_" prefix from all those static function names. This one
is even inline, which means its name doesn't matter at all.

> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 count;
> +
> +	layout = snp_map_secrets_page();
> +	if (!layout)
> +		return 0;
> +
> +	/* Read the current message sequence counter from secrets pages */
> +	count = readl(&layout->os_area.msg_seqno_0);
> +
> +	iounmap(layout);
> +
> +	/* The sequence counter must begin with 1 */

That sounds weird. Why? 0 is special?

> +	if (!count)
> +		return 1;
> +
> +	return count + 1;
> +}
> +
> +u64 snp_msg_seqno(void)

Function name needs a verb. I.e.,

	 snp_get_msg_seqno()

> +{
> +	u64 count = snp_read_msg_seqno();
> +
> +	if (unlikely(!count))

That looks like a left-over from a previous version as it can't happen.

Or are you handling the case where the u64 count will wraparound to 0?

But "The sequence counter must begin with 1" so that read function above
needs more love.

> +		return 0;


> +
> +	/*
> +	 * The message sequence counter for the SNP guest request is a
> +	 * 64-bit value but the version 2 of GHCB specification defines a
> +	 * 32-bit storage for the it.
> +	 */
> +	if (count >= UINT_MAX)
> +		return 0;

Huh, WTF? So when the internal counter goes over u32, this function will
return 0 only? More weird.

> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
> +
> +static void snp_gen_msg_seqno(void)

That's not "gen" - that's "inc" what this function does. IOW,

	snp_inc_msg_seqno

> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 count;
> +
> +	layout = snp_map_secrets_page();
> +	if (!layout)
> +		return;
> +
> +	/*
> +	 * The counter is also incremented by the PSP, so increment it by 2
> +	 * and save in secrets page.
> +	 */
> +	count = readl(&layout->os_area.msg_seqno_0);
> +	count += 2;
> +
> +	writel(count, &layout->os_area.msg_seqno_0);
> +	iounmap(layout);

Why does this need to constantly map and unmap the secrets page? Why
don't you map it once on init and unmap it on exit?

> +}
> +
>  int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
>  {
>  	struct ghcb_state state;
> @@ -2077,6 +2153,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
>  		ret = -EIO;
>  	}
>  
> +	/* The command was successful, increment the sequence counter */
> +	snp_gen_msg_seqno();
> +
>  e_put:
>  	__sev_put_ghcb(&state);
>  e_restore_irq:
> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
> index 24dd17507789..16b6af24fda7 100644
> --- a/include/linux/sev-guest.h
> +++ b/include/linux/sev-guest.h
> @@ -20,6 +20,41 @@ enum vmgexit_type {
>  	GUEST_REQUEST_MAX
>  };
>  
> +/*
> + * The secrets page contains 96-bytes of reserved field that can be used by
> + * the guest OS. The guest OS uses the area to save the message sequence
> + * number for each VMPCK.
> + *
> + * See the GHCB spec section Secret page layout for the format for this area.
> + */
> +struct secrets_os_area {
> +	u32 msg_seqno_0;
> +	u32 msg_seqno_1;
> +	u32 msg_seqno_2;
> +	u32 msg_seqno_3;
> +	u64 ap_jump_table_pa;
> +	u8 rsvd[40];
> +	u8 guest_usage[32];
> +} __packed;

So those are differently named there:

struct secrets_page_os_area {
	uint32 vmpl0_message_seq_num;
	uint32 vmpl1_message_seq_num;
	...

and they have "vmpl" in there which makes a lot more sense for that
they're used than msg_seqno_* does.

> +
> +#define VMPCK_KEY_LEN		32
> +
> +/* See the SNP spec for secrets page format */
> +struct snp_secrets_page_layout {

Simply

	struct snp_secrets

That name says all you need to know about what that struct represents.

> +	u32 version;
> +	u32 imien	: 1,
> +	    rsvd1	: 31;
> +	u32 fms;
> +	u32 rsvd2;
> +	u8 gosvw[16];
> +	u8 vmpck0[VMPCK_KEY_LEN];
> +	u8 vmpck1[VMPCK_KEY_LEN];
> +	u8 vmpck2[VMPCK_KEY_LEN];
> +	u8 vmpck3[VMPCK_KEY_LEN];
> +	struct secrets_os_area os_area;

My SNP spec copy has here

0A0h–FFFh	Reserved.

and no os area. I guess

SEV Secure Nested Paging Firmware ABI Specification 56860 Rev. 0.8 August 2020

needs updating...

> +	u8 rsvd3[3840];
> +} __packed;
> +
>  /*
>   * The error code when the data_npages is too small. The error code
>   * is defined in the GHCB specification.
> @@ -36,6 +71,7 @@ struct snp_guest_request_data {
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>  			    unsigned long *fw_err);
> +u64 snp_msg_seqno(void);
>  #else
>  
>  static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
> @@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
>  {
>  	return -ENODEV;
>  }
> +static inline u64 snp_msg_seqno(void) { return 0; }
>  
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
>  #endif /* __LINUX_SEV_GUEST_H__ */
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
