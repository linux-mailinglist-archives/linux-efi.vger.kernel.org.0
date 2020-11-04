Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D52A63F2
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgKDMLw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 07:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDMLv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 07:11:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D03C0613D3
        for <linux-efi@vger.kernel.org>; Wed,  4 Nov 2020 04:11:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so2427631wrc.11
        for <linux-efi@vger.kernel.org>; Wed, 04 Nov 2020 04:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWBXgJnP6ZMmAVaJhl+iR2yivrPLX4y7qTlVADqn+sQ=;
        b=02EU0SugVCvcNv5FZKpz4AouKz2Hd0mP5NCdXYWBe8Ow8wnnu2Gb9V3HBWS3pkIqC2
         AaSSsxieSHboL/jsVD4YWTW+VTwa2z1i5whvLZFzVz/J2tMQFok6LxDslPK1Fen7v2WL
         Lcxm8dOiLEPzA1M1Il0a4ehrzZHUagIq63dawoeay9OQ5FHV1ElKgHHAWghWtdwhgyrF
         KVLiV0cIdoOhLWDz2xdht4cMrsekFZsxIVcVORqeWNsEpJx9C1zTAjYaOyL3RZyN49kL
         A9DD+L3R8MmUqOMl3An3C3g6rHPi6nOeP2PTAMmkHMCBLEbiWuBlrwepvZavkDtjwFVn
         BDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWBXgJnP6ZMmAVaJhl+iR2yivrPLX4y7qTlVADqn+sQ=;
        b=Mrz0GBx3l3E51n2ZWieZ911kEa1YgdEXbSkb+vfnqLHq3YKrxr8/ztUwSckgQM1mZZ
         2aE75UAa4MWPw8dW+wmJeDLV2xIlksk8m4EVhPK8RRKQY+eHKXGln1XG8O+4hKoRdS/L
         eDO2tEcH56KqWWTFU+LX+rKWQB4Uqw6xkyEyuPXGTS48moG+orXk0qo0M15xnwMnQaVs
         vYyCXhjtF/1myDnm/fp/sPs7T1bahK8apEmEkjYzGHP3VhaORpB6tYouKMobV/8NUKph
         GLSC5/cg4yfxkFBOARh7BegKE279eAwteL96Asm9Z6r1rKetUbp7xA8NQL0LQR5EnxVr
         HQrQ==
X-Gm-Message-State: AOAM531nYD3jDGdxEmL7JbUZRjH98aEjqUtwUyVGb8J/3knHqz9NltoX
        yR5gzn2RrkdS3y3QfSM2A/T98w==
X-Google-Smtp-Source: ABdhPJwcW7xxOT2fCMTy+ARJtIrMwVEjH9MT8L56YudRzFer8fExYnGFG+7EcvahcnaTdASFqcPtcw==
X-Received: by 2002:adf:f1c1:: with SMTP id z1mr32315036wro.331.1604491908650;
        Wed, 04 Nov 2020 04:11:48 -0800 (PST)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net. [82.27.104.80])
        by smtp.gmail.com with ESMTPSA id u15sm2133387wrm.77.2020.11.04.04.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:11:48 -0800 (PST)
Date:   Wed, 4 Nov 2020 12:11:46 +0000
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        daniel.kiper@oracle.com
Subject: Re: [PATCH v2 1/8] linux/arm: fix ARM Linux header layout
Message-ID: <20201104121146.GT1664@vanye>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-2-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025134941.4805-2-ard.biesheuvel@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 25, 2020 at 14:49:34 +0100, Ard Biesheuvel wrote:
> The hdr_offset member of the ARM Linux image header appears at
> offset 0x3c, matching the PE/COFF spec's placement of the COFF
> header offset in the MS-DOS header. We're currently off by four,
> so fix that.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>  include/grub/arm/linux.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/grub/arm/linux.h b/include/grub/arm/linux.h
> index 2e98a6689696..bcd5a7eb186e 100644
> --- a/include/grub/arm/linux.h
> +++ b/include/grub/arm/linux.h
> @@ -30,7 +30,7 @@ struct linux_arm_kernel_header {
>    grub_uint32_t magic;
>    grub_uint32_t start; /* _start */
>    grub_uint32_t end;   /* _edata */
> -  grub_uint32_t reserved2[4];
> +  grub_uint32_t reserved2[3];
>    grub_uint32_t hdr_offset;

How did this ever work?

/
    Leif

>  };
>  
> -- 
> 2.17.1
> 
