Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022FA48C326
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 12:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352871AbiALLbR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 06:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237766AbiALLbR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 06:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641987073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C66zPnUJeDWEIlSEzKy00mOLRxBuQ1dDqv+Z3TGt8nE=;
        b=VZ8oIMjo3qyUq2djTV9a4M0HLengLB2AQyKD8nGW3pE2tHZNjX85z59TH4WAJcHE/gvVlm
        HoNinQ8L34nDgRQfFwya/hBz66cIdwq1upiuemPJtZFQ/fkmcsc43T1ZPXRIcSK5McR6+q
        51WT3tSBbNHHYoZEjJnLSyzhbnm6N6c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-fRJg1iGyO1a0wIo_jIKG3w-1; Wed, 12 Jan 2022 06:31:12 -0500
X-MC-Unique: fRJg1iGyO1a0wIo_jIKG3w-1
Received: by mail-ed1-f71.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so1999756edd.11
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 03:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=C66zPnUJeDWEIlSEzKy00mOLRxBuQ1dDqv+Z3TGt8nE=;
        b=3ALj2QNhlTfejAl94v9ZIa+98WF/m+iI73zf84dkaAYbRZMrczKYIbpHs6GDIl3Qa5
         kkVt5YKyQYs3EYMkA99taCcyw1iW8UJuNTPkbVrrJv1f1Px/7HcGQw7ubLWCJp4YsKcJ
         8GLs4zkK8TB9nMQI7vtNR/cj5ilbFiaUm3f7YutqAlAcv7zo6vKZMavp3kaYomPqkb8q
         SYhs3uWLe5c4fhD3THweKuQLz3e6EgaHUyMW0IQdjqe9KOngKd1GMQdJrj2dd/fNUF+A
         NBNLf0s1aby9cokyayEMedN+FkoFUtxcBPPzkvnsJvz3mE1UVy1YDamooMmFAbZS2iHw
         4EDw==
X-Gm-Message-State: AOAM530JZQ1P++y/guZ9KfDPQZD3Rbk42QJi30S1XId+Hkz3hnhxtp+x
        Jw399axlTmJKD4DpLKhRxjlPPdmtUtQdXrspu1Is4wkjdqYkjw0nS4c+4Wfr52Od+iS/3ppYvFW
        ySk+Kcc+c8hnCnjGlnGJU
X-Received: by 2002:a17:906:f243:: with SMTP id gy3mr7322350ejb.432.1641987071760;
        Wed, 12 Jan 2022 03:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsE7p0G+4kzPLfTKaUz/IaDx53eZn3tKCrLaSx+D5x62EAUjJVBrepv4kYr8O17+iEwsPgQQ==
X-Received: by 2002:a17:906:f243:: with SMTP id gy3mr7322324ejb.432.1641987071547;
        Wed, 12 Jan 2022 03:31:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id r17sm409452edw.70.2022.01.12.03.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:31:11 -0800 (PST)
Message-ID: <d84e242f-f7f6-4fb0-8f22-bcc790a296a0@redhat.com>
Date:   Wed, 12 Jan 2022 12:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-2-kirill.shutemov@linux.intel.com>
 <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv2 1/7] mm: Add support for unaccepted memory
In-Reply-To: <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> 
> Looking at stuff like this, I can't help but think that a:
> 
> 	#define PageOffline PageUnaccepted
> 
> and some other renaming would be a fine idea.  I get that the Offline 
> bit can be reused, but I'm not sure that the "Offline" *naming* should 
> be reused.  What you're doing here is logically distinct from existing 
> offlining.

Yes, or using a new pagetype bit to make the distinction clearer.
Especially the function names like maybe_set_page_offline() et. Al are
confusing IMHO. They are all about accepting unaccepted memory ... and
should express that.

I assume PageOffline() will be set only on the first sub-page of a
high-order PageBuddy() page, correct?

Then we'll have to monitor all PageOffline() users such that they can
actually deal with PageBuddy() pages spanning *multiple* base pages for
a PageBuddy() page. For now it's clear that if a page is PageOffline(),
it cannot be PageBuddy() and cannot span more than one base page.

E.g., fs/proc/kcore.c:read_kcore() assumes that PageOffline() is set on
individual base pages.

-- 
Thanks,

David / dhildenb

