Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF83CEE74
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348363AbhGSU5k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384170AbhGSSYX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 14:24:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F879C0613E1
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 11:52:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso151531pjz.1
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9m2rZHOVB1NoZtYoNA6EFBVCz7Bbir+fDae0NyH8yOk=;
        b=cKMSuskXfTZmYOL+qFY2CjsQm3HSNuYn6k9NptZ+JPJvmISriI4cZ3yoIyeYtyxvv1
         7oGLcbXabYb6lI+2vVxKFEJvm0ak02KG+H7bbNvqNZVkkmSiKcPJdAFjSPe2MDdu91II
         l5JB7D82QfrUjFShHZTnPAy+smnwbQuWDI0w462/H1ygcKedZSNtC5I7u7xO9JNeg7vg
         JqJAwxUtVLVBsS9kTMF9Thfv1hSTtzrZlIZ31izAavsZjUTXVHIXgvyzcT/qV9CGue75
         c7WuDs77rTWCMSdOjcww3bR8tv6L5H28sqTZcJJbnPEzgwpVo2WWSvCNXmrmWKdZYdE+
         Hl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9m2rZHOVB1NoZtYoNA6EFBVCz7Bbir+fDae0NyH8yOk=;
        b=VCekmYbTT6uwDKqJO7QdeKVVJk5c999ql/MbGVBmFwc35vBJ9pWrSayBGI/BJqj8WY
         yGEFSf2tUjWMMOdFADJHkdYlyGhvQLwsR8Gjcy+V3Z6yxzhGWkpzDgq7w9KgmFz6jJik
         kBJ03FIe5oayEWLD4QNaDp+bkC55K0iZ6adA6QZvMk//3h1VpAIqnjIEkxtQQLyO5Q0O
         +xbNmRq4SUdaZbEjI38jgfIP2lk1+rdPa9uq2FR63iYY1WGbzBf5Ef974jX6s0rBt/eb
         Wcqz7ku+sNWpjv+4asznhpHAkW2q+ad84IKEKAqAU+AmIIiXXxglA1vVUHW4tLYGvMwr
         pkXA==
X-Gm-Message-State: AOAM532eDkdDK8wY/pXWnONehkmDF3UsaBx84GR1faaHzIvXeOol64P5
        TroKZdpfJv+0rcIpneY44A2Hvg==
X-Google-Smtp-Source: ABdhPJzKRz7pQLf5Lk3Ijby/XshCZupalvr6olwQaiWS02HChg4VytvEL0vS1aw+zs+u/vaUP8R/OA==
X-Received: by 2002:a17:90a:d486:: with SMTP id s6mr26678412pju.142.1626721391280;
        Mon, 19 Jul 2021 12:03:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f7sm20453955pfc.111.2021.07.19.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:03:10 -0700 (PDT)
Date:   Mon, 19 Jul 2021 19:03:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages
 when SEV-SNP VM terminates
Message-ID: <YPXMas+9O1Y5910b@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-26-brijesh.singh@amd.com>
 <YPHnb5pW9IoTcwWU@google.com>
 <2711d9f9-21a0-7baa-d0ff-2c0f69ca6949@amd.com>
 <YPIoaoDCjNVzn2ZM@google.com>
 <e1cc1e21-e7b7-5930-1c01-8f4bb6e43b3a@amd.com>
 <YPWz6YwjDZcla5/+@google.com>
 <912c929c-06ba-a391-36bb-050384907d81@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912c929c-06ba-a391-36bb-050384907d81@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 19, 2021, Brijesh Singh wrote:
> 
> On 7/19/21 12:18 PM, Sean Christopherson wrote:
> > > 
> > > Okay, I will add helper to make things easier. One case where we will
> > > need to directly call the rmpupdate() is during the LAUNCH_UPDATE
> > > command. In that case the page is private and its immutable bit is also
> > > set. This is because the firmware makes change to the page, and we are
> > > required to set the immutable bit before the call.
> > 
> > Or do "int rmp_make_firmware(u64 pfn, bool immutable)"?
> 
> That's not what we need.
> 
> We need 'rmp_make_private() + immutable' all in one RMPUPDATE.  Here is the
> snippet from SNP_LAUNCH_UPDATE.

Ah, not firmwrare, gotcha.  But we can still use a helper, e.g. an inner
double-underscore helper, __rmp_make_private().
