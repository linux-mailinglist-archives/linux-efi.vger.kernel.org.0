Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68173CA5A4
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGOSmO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGOSmL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 14:42:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A4C061760
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 11:39:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y4so6293486pfi.9
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3Y0+ogDVT6wqAQ9ZQs2NyHc5pJHUCbPNwTdIK9PvNA=;
        b=Qv3S59LCo5Nmv9xeE85vyXWs0GZOA6KpAsz49t1UEOxMwgH2P9Y4ljAK74msMmTt2O
         UNWvggYks0hDjPx8QyMfkCWn1CjZq5S9eiunJ77QL6TXq8rwRbAtkjCrdhgbFBYUHgxn
         L09H6z5RM3mwM5tX1LZl0rsd/lRhtL/FHHzGNIW6VhH3AJY+KQQ3s+h2yPt5segk0grk
         8v5UWFkaC2eF83kmN+zNi9f9KERgDwDm+RB+yjbQirrVge0ZjGQhKibLQ48L41+LPY+j
         7ZDohtKMPav2yX+ZJlS4XbJ63NiCsEP02INCQtD+ISzPHyO6hXsIkY+T4rbRtxzv5vb1
         fVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3Y0+ogDVT6wqAQ9ZQs2NyHc5pJHUCbPNwTdIK9PvNA=;
        b=FQLmxJSUP7GW2i1ckSLBbkPKyFzGR2m8UyMZiUfP8Io5iJV83/j6Rk1GdAs92k9Qxk
         3m411eS1PlhwUNVZ9tMjzQcYgUofZQ7+Y1AX2qTk3/v1sfccYuLqbqa59uwFoJNtU8oT
         JiA8wkUOxOw+b8mS5Nud2lxgM0YglFL7EEXnJSZn7aALiG8MqqDztUnTb0a1v8fIWnwA
         2o67WpgWs84sOhQHHRS+Scy+UEEz4djBOIWT6Ad5u6HUyAV/+5Wp4KQTJ5IBLYckR3Am
         Ung2ZFTDxvNAg/m00ICWXVRzL+BSbtb9NqLNhw4Ow8fU7j3tggrtVhmF7dihgotnKDyh
         j7Ag==
X-Gm-Message-State: AOAM533LqhYqF+4mwGdHqx+UZIAKWQvfV3/Ix8nloDmFpRnFWj1q8IEu
        s6+DVxrwfwXfGa9BMlQlx4rm3w==
X-Google-Smtp-Source: ABdhPJz+1iaVBL+ABO/O1tBChzrqhVRnDYERNo2Clv19fhDRGqCjbjbdtc1OIE70QPX9w7Agiv3K8Q==
X-Received: by 2002:a62:19c9:0:b029:32a:129f:542d with SMTP id 192-20020a6219c90000b029032a129f542dmr5859523pfz.8.1626374356838;
        Thu, 15 Jul 2021 11:39:16 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 73sm6267842pjz.24.2021.07.15.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:39:16 -0700 (PDT)
Date:   Thu, 15 Jul 2021 18:39:12 +0000
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
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when
 adding the page in RMP table
Message-ID: <YPCA0A+Z3RKfdsa3@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com>
 <YO9kP1v0TAFXISHD@google.com>
 <d486a008-8340-66b0-9667-11c8a50974e4@amd.com>
 <YPB1n0+G+0EoyEvE@google.com>
 <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 15, 2021, Brijesh Singh wrote:
> The memfd_secrets uses the set_direct_map_{invalid,default}_noflush() and it
> is designed to remove/add the present bit in the direct map. We can't use
> them, because in our case the page may get accessed by the KVM (e.g
> kvm_guest_write, kvm_guest_map etc).

But KVM should never access a guest private page, i.e. the direct map should
always be restored to PRESENT before KVM attempts to access the page.
