Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7553B80C
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jun 2022 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiFBLtL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jun 2022 07:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiFBLs5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jun 2022 07:48:57 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358212B1D42;
        Thu,  2 Jun 2022 04:48:54 -0700 (PDT)
Received: from localhost (91-154-92-55.elisa-laajakaista.fi [91.154.92.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sakkinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id B102C20050;
        Thu,  2 Jun 2022 14:48:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1654170531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tl5Jw+UulbKqEMtgUT3K2V354kKV5SSHEf74OZxYd5E=;
        b=gVIvyyFheZVOW68udFbl3Qpp9M7jjcbWm9FiuKuldUA0wBr/wcvKOh6oKSlm0FoFCrGc0G
        lsOlYPhv+Htk32XWaDLY8BMfz1Jnnqwv08tgZW6pNc7J1LCWEyUaQoUcrTB+nmUKwkfWEj
        JxvXIkollSXLISgj1FALNvEyep0VQpE=
Date:   Thu, 2 Jun 2022 14:47:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 04/40] x86/sev: Add the host SEV-SNP
 initialization support
Message-ID: <YpijNgA9ZJFOwF8k@kernel.org>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-5-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-5-brijesh.singh@amd.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1654170531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tl5Jw+UulbKqEMtgUT3K2V354kKV5SSHEf74OZxYd5E=;
        b=ePgDehaSBHMbAUeRp95u13p4p8R22l6vqZ0Y7PeMjozqI0sCl7tMMSg7fa+Rj8EsK12Dq9
        Q7NAMreqVW2DSqoiku0beXey8bOa/CKisFZf3su1o1Em6zHYFfxJIU+ZuM+wjtgiMaLuei
        EBgApVVinLsgcmdA6hz+r0XtTmGpcfw=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1654170531; a=rsa-sha256; cv=none;
        b=LC1JwZgfmfj/q89WJnmLomXZ9I33E8D3pncYsBCxYXrtbfkGKulazshKvHVgPXgYyOeUvZ
        oWMRAL0kUm5nnedlv5afvZAt1bUMzvZNHXZE7+RfG1jmq5cNNtqWJfwl2OhNbt7c2V12yD
        aaXkQguiVODIdoopJVtYpj7pyRE7tp8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021 at 01:35:40PM -0500, Brijesh Singh wrote:
> The memory integrity guarantees of SEV-SNP are enforced through a new
> structure called the Reverse Map Table (RMP). The RMP is a single data
> structure shared across the system that contains one entry for every 4K
> page of DRAM that may be used by SEV-SNP VMs. The goal of RMP is to
> track the owner of each page of memory. Pages of memory can be owned by
> the hypervisor, owned by a specific VM or owned by the AMD-SP. See APM2
> section 15.36.3 for more detail on RMP.
> 
> The RMP table is used to enforce access control to memory. The table itself
> is not directly writable by the software. New CPU instructions (RMPUPDATE,
> PVALIDATE, RMPADJUST) are used to manipulate the RMP entries.

What's the point of throwing out a set of opcodes, if there's
no explanation what they do?

BR, Jarkko
