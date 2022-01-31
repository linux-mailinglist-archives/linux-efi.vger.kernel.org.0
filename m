Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54DA4A537C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiAaXoO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 18:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiAaXoC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jan 2022 18:44:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8BC061714
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 15:44:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y15so30143090lfa.9
        for <linux-efi@vger.kernel.org>; Mon, 31 Jan 2022 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+h8DeuUfkcjLos3BviUGDVOpxtzirtyuHipEzyipWwg=;
        b=LEHAp+tjvjupiksn3rRU+MTYTYJP1zmZug2s1ZZldzoTJGpYo9m+xIPjubK2rtcde8
         GPVx0URubvo/jJvle5RTJhnlLC6JqkPwVNpFtC6I83045f95Guvh3joXjYsjHykGAlhq
         92OP3IdGZsIVkSJitzv8T5+TJfntyXg5hJSlvUP6BKmhR65VEndbO031zvU3CMnXmYk9
         37chJ05w0IkvWVqNAA3kZqvLNIDXrV27x1B83Wu+CnJ9lk9O+BCi95z2rkMNtZXgJub7
         vR4PpZz9noMFzfCD8iynifIes6TpoGPVFMyIInGkSWaFrJWp7gVEPpedEqol12ZjoTY0
         Ef8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+h8DeuUfkcjLos3BviUGDVOpxtzirtyuHipEzyipWwg=;
        b=RSUdjz3ReTKfJivVm4UjqUg8zyx6c9SonwoZYMLBspIXwH2ZCHp5Fgj9bTnJX+T+TO
         hDLgiE20cJZuvD5k3UKp6PEoxNv42UK6P2cbzcxfdDXaeZg5GFEKn333MdWi/xPgC0Ur
         Gb6Ro5U/+JJv7OrWhCGby3x6vziQoAbBmPksf1363iAg27qJdCiDdM8hT4t/L7ianAVL
         X2f/yzRoxJUFObeD2B9h7iUTqxwnUp0rJDsyOZeefKkfdZ022tBoLsSAkQ88PTaNgZbB
         gp+j/NMwEZldbjdXG63nO+1bNt2kFUYTNuOJ/JcJliHzmIQZ9i8pH8rbIQ0dsnUkmOYb
         jCrQ==
X-Gm-Message-State: AOAM530b7BHcONOGszUe+7YqVZMivIjugpIa3uHNLXBG99dgNCubGWWf
        v+l99yf6d6apPBDqdgvhzhEAAA==
X-Google-Smtp-Source: ABdhPJy9muQCEl5VEBzDXlXUJUJcCiNqcoX+SUeTK/d+sBX/xKeTfWiTXJNIQJsO4DDl7bWle3JZBg==
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr16771617lfg.219.1643672640599;
        Mon, 31 Jan 2022 15:44:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m12sm3812652lfj.90.2022.01.31.15.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:43:59 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5452110458C; Tue,  1 Feb 2022 02:44:37 +0300 (+03)
Date:   Tue, 1 Feb 2022 02:44:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/7] efi/x86: Get full memory map in allocate_e820()
Message-ID: <20220131234437.twazkxvsdukhq2xs@box.shutemov.name>
References: <20220128205906.27503-1-kirill.shutemov@linux.intel.com>
 <20220128205906.27503-3-kirill.shutemov@linux.intel.com>
 <101a4497-ae17-ab69-640d-667c79da639b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101a4497-ae17-ab69-640d-667c79da639b@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 31, 2022 at 02:38:42PM -0800, Dave Hansen wrote:
> On 1/28/22 12:59, Kirill A. Shutemov wrote:
> > Modify allocate_e820() to get a full memory map.
> 
> Dumb question time: why doesn't the current code get a full memory map?
>  This looks simpler.  What's the downside?  Memory consumption?

Yeah, it requires memory allocation that has to be freed back.

Otherwise I don't see any downsides. There are several more EFI calls, but
it should not make a noticable difference on boot time.

-- 
 Kirill A. Shutemov
