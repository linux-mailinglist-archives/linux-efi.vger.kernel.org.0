Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3893C9393
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhGNWJg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGNWJd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Jul 2021 18:09:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9CC061762
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 15:06:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x16so2162246plg.3
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaE6jTG7Jgp/wbJ51tcMag9jCDCxqqxrr8OYq3+P8Wc=;
        b=fL0PZANAF7+yG7iFWgSd0V41pH9og2KfTI28bNb7PFPqhsxWX1vWBJSpG2i6Gjo3SZ
         uBkrJV6sEMNsi4qSAdBqBw6tNA4B71VFB3gdu6TfTguqNp+oWfN0A8chWUHiYxHZ/fKm
         wgGdo/wDMcwfUjzOKc4q6oFaOM+c91HVF3pRWA3wTmCaPr6/CcGFVU7B1axKZTQrVa28
         LHCmlpj7Q5nQ1el6lq4k2IOkZPpOk4BUvA2r7goLspzc1hNMvuoQvJgQFYWvKwSEyqVB
         Nc2gDt1zoJKsYGVTvY39xgk29AnP5yE3Goc6Ba55GzQtKyJRNCuXbSZUsmeTVgE+te5V
         99vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaE6jTG7Jgp/wbJ51tcMag9jCDCxqqxrr8OYq3+P8Wc=;
        b=FX06maLdoD/4EhLPRK/l//5khuRiPpbUG2/E0sRDpUH08GBVCoaxbVAK0dqosNEZ1H
         YkcmdtYkWl1cU2ORC17GY/qwrluYpKae9KOPEReFE6lUfEqRBIoKupWK3loufleViWqy
         dyRYqiD4oQgiQ/Y6q9qEzQx9QvzqUifaPlGxVKzpBWroJnnZ+eXgMpQMB99Bg7bIbXt1
         fNH+Vse3Y4I0t5WhZCRJ5EQMEkyHxDrUpipMhBe/xqbMiq4Pui6zMbQEHrcgB2vdmUxM
         5UMW67Uquc7ajIcYNUfnxgKoSypKw7Fqzv0zEKhqnNi7pQvFqs7/izLmpGG/FRMaVafY
         nB9A==
X-Gm-Message-State: AOAM531AofeiGvAdEQdX1firctKjQE6Ez/0oDn61wdfzmtOpFnQZus7r
        ZMWn+PlvyL0LoPYYYJUNSPQEPg==
X-Google-Smtp-Source: ABdhPJzL6E0xTKEWU8gTQC7tUf662bWjjkN53TDiamtXaZuo10SO8nSFMPFMKZBypBAnyU1O6Ez5kQ==
X-Received: by 2002:a17:90a:f3cb:: with SMTP id ha11mr5820993pjb.144.1626300399715;
        Wed, 14 Jul 2021 15:06:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id bf18sm3109402pjb.46.2021.07.14.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:06:39 -0700 (PDT)
Date:   Wed, 14 Jul 2021 22:06:35 +0000
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
Subject: Re: [PATCH Part2 RFC v4 04/40] x86/sev: Add the host SEV-SNP
 initialization support
Message-ID: <YO9f63RwTckAEZ1n@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-5-brijesh.singh@amd.com>
 <YO9SGT6byW8w37oO@google.com>
 <31e57173-449a-6112-30ac-5b115dda1dbb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e57173-449a-6112-30ac-5b115dda1dbb@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 14, 2021, Brijesh Singh wrote:
> The bookkeeping region is at the start of the RMP_BASE. If we look at the
> PPR then it provides a formula which we should use to read the RMP entry

What's the PPR?  I get the feeling I'm missing a spec :-)
