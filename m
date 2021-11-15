Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D645063F
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhKOOIt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 09:08:49 -0500
Received: from 8bytes.org ([81.169.241.247]:52816 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhKOOIp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Nov 2021 09:08:45 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D6E13398; Mon, 15 Nov 2021 15:05:47 +0100 (CET)
Date:   Mon, 15 Nov 2021 15:05:41 +0100
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 15/45] x86/compressed: Register GHCB memory when
 SEV-SNP is active
Message-ID: <YZJpNZyW8MtNZ44s@8bytes.org>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211110220731.2396491-16-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 10, 2021 at 04:07:01PM -0600, Brijesh Singh wrote:
> +static void snp_register_ghcb_early(unsigned long paddr)

This needs __maybe_unused, otherwise it triggers a warning:

arch/x86/kernel/sev-shared.c:78:13: warning: ‘snp_register_ghcb_early’ defined but not used [-Wunused-function]
   78 | static void snp_register_ghcb_early(unsigned long paddr)
      |             ^~~~~~~~~~~~~~~~~~~~~~~

