Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF34456B6
	for <lists+linux-efi@lfdr.de>; Thu,  4 Nov 2021 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhKDQF7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Nov 2021 12:05:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhKDQF6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Nov 2021 12:05:58 -0400
Received: from [127.0.0.1] (dynamic-046-114-037-055.46.114.pool.telefonica.de [46.114.37.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E61611EC03AD;
        Thu,  4 Nov 2021 17:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636041799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4evrOHd0IfTyrs3k9/fwX+W/P75BgRT5NqUyOT/QhA=;
        b=MfYrIi/NzQzu7+bUg8+JE8a/TjdlOnIxd1Ge1UeACXOJRNorLjOjCGPP2/IX3XfM4XWYch
        J+HgUXwKITXMoxJV2gESgaK97zM9aRSiRhSnUzToelJvc4z36gX3fHpH5mvFXVlQXFcdzp
        cs5LiiOtD9sx6+Z9xuk74MSKNsFALDI=
Date:   Thu, 04 Nov 2021 16:03:15 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
CC:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-efi@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ingo Molnar <mingo@redhat.com>, tony.luck@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Peter Gonda <pgonda@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, marcorr@google.com,
        Andi Kleen <ak@linux.intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_14/42=5D_x86/sev=3A_Regist?= =?US-ASCII?Q?er_GHCB_memory_when_SEV-SNP_is_active?=
User-Agent: K-9 Mail for Android
In-Reply-To: <47815dd4-f9ac-b141-2852-8f48c8299a5e@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com> <20211008180453.462291-15-brijesh.singh@amd.com> <YYFs+5UUMfyDgh/a@zn.tnic> <aea0e0c8-7f03-b9db-3084-f487a233c50b@amd.com> <YYGGv6EtWrw7cnLA@zn.tnic> <a975dfbf-f9bb-982e-9814-7259bc075b71@amd.com> <YYPnGeW+8tlNgW34@zn.tnic> <47815dd4-f9ac-b141-2852-8f48c8299a5e@amd.com>
Message-ID: <C01A4C34-D84A-4489-A2D0-91003B9B564C@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On November 4, 2021 3:26:56 PM UTC, Brijesh Singh <brijesh=2Esingh@amd=2Eco=
m> wrote:
>Of course, the current patch does not suffer with it=2E Let me know your=
=20
>preference=2E

Whatever keeps the code simpler=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
