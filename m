Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D034E558AEF
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jun 2022 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiFWVti (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jun 2022 17:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFWVti (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Jun 2022 17:49:38 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D8609D6;
        Thu, 23 Jun 2022 14:49:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:50126)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o4Uhd-00DJj7-3e; Thu, 23 Jun 2022 15:49:29 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57444 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o4Uhb-0022ce-V4; Thu, 23 Jun 2022 15:49:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
        <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
        <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
Date:   Thu, 23 Jun 2022 16:48:59 -0500
In-Reply-To: <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com> (Dave Hansen's
        message of "Thu, 23 Jun 2022 10:23:59 -0700")
Message-ID: <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o4Uhb-0022ce-V4;;;mid=<87a6a3aw50.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18FcaF4uvLQyjo+A0LkxE1aFqSrnDlgmHM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Dave Hansen <dave.hansen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 559 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.8%), parse: 0.99
        (0.2%), extract_message_metadata: 24 (4.3%), get_uri_detail_list: 1.45
        (0.3%), tests_pri_-1000: 23 (4.2%), tests_pri_-950: 1.75 (0.3%),
        tests_pri_-900: 1.46 (0.3%), tests_pri_-90: 154 (27.5%), check_bayes:
        150 (26.8%), b_tokenize: 14 (2.4%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 3.4 (0.6%), b_tok_touch_all: 117 (20.9%), b_finish: 1.45
        (0.3%), tests_pri_0: 322 (57.6%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 12 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted memory
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> ... adding kexec folks
>
> On 6/14/22 05:02, Kirill A. Shutemov wrote:
>> On kexec, the target kernel has to know what memory has been accepted.
>> Information in EFI map is out of date and cannot be used.
>> 
>> boot_params.unaccepted_memory can be used to pass the bitmap between two
>> kernels on kexec, but the use-case is not yet implemented.
>> 
>> Disable kexec on machines with unaccepted memory for now.
> ...
>> +static int __init unaccepted_init(void)
>> +{
>> +	if (!boot_params.unaccepted_memory)
>> +		return 0;
>> +
>> +#ifdef CONFIG_KEXEC_CORE
>> +	/*
>> +	 * TODO: Information on memory acceptance status has to be communicated
>> +	 * between kernel.
>> +	 */
>> +	pr_warn("Disable kexec: not yet supported on systems with unaccepted memory\n");
>> +	kexec_load_disabled = 1;
>> +#endif
>
> This looks to be the *only* in-kernel user tweaking kexec_load_disabled.
>  It doesn't feel great to just be disabling kexec like this.  Why not
> just fix it properly?
>
> What do the kexec folks think?

I didn't realized someone had implemented kexec_load_disabled.  I am not
particularly happy about that.  It looks like an over-broad stick that
we will have to support forever.

This change looks like it just builds on that bad decision.

If people don't want to deal with this situation right now, then I
recommend they make this new code and KEXEC conflict at the Kconfig
level.  That would give serious incentive to adding the missing
implementation.

If there is some deep and fundamental why this can not be supported
then it probably makes sense to put some code in the arch_kexec_load
hook that verifies that deep and fundamental reason is present.

With the kexec code all we have to verify it works is a little testing
and careful code review.  Something like this makes code review much
harder because the entire kernel has to be checked to see if some random
driver without locking changed a variable.  Rather than having it
apparent that this special case exists when reading through the kexec
code.

Eric

