Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD67F1128E5
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 11:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfLDKJX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 05:09:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40760 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfLDKJW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 05:09:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so7779502wrn.7;
        Wed, 04 Dec 2019 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=raeCtC+dljo0qv32p8D/VuYe95bGrREsFJM19wAQqc8=;
        b=KNNpisM7QR9D0AXGY6S7UtWvFsgqwnLg/z6E+LyY7Z/PFWc7kGnrlFu6LchmdcXtYB
         aGFWUf0fW3q2g4j/4SBrKGBNBUhWnrbisCgGNU+O/SwpJUczZTtjNty4T25ydIG98Gu0
         9tjFel3etp4TbLMLYVAJvGJ/BCaQguKU3Q3dh1z+kJlCkHV35WqyjNshFNyMS9cS0Ycj
         6tjRA7/DKcSkDXS+IXLd/FUf4vTKPti5MP+kI0gqdrTwTDhcsKKQVajzp5h4/DqqfJzf
         wy5VqBQLFm7a2H9Tj5EmLjZ+SXc0gFVn8MlNI8+nmozpPRfnwMOu53xH3mUvHFM6ToJJ
         VfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=raeCtC+dljo0qv32p8D/VuYe95bGrREsFJM19wAQqc8=;
        b=m9P0nEAY+LH079XRoTxkiUt2k0fxCDFz5WK0DVZhGkNJXI4Ca16HHd2lQqOHv7bc/h
         Gogdv4WNob5rUcBnVDNQfK1dCEjoL2xpdN6i0OxvOZLJpySCWTdvBLUVtkxkeIi/nvy3
         6jjBjKKMoxlE0qpNuh20jy1sj/odrQII2BLmoFqw7IHz2Z4tsH2x88u1h93TjPwth5lT
         aihHEod4EioxEjPOCpc1D+iqJFHDN1slT126681LeNSavtR+L4QUuRffjfFNtDesqor1
         stNvH2WHxOy7t5cBR1oPnPgQj8LJgV+vNLDVT955cJDfzQOh+7BAHOR4S9T1Os+HhvS4
         PEXg==
X-Gm-Message-State: APjAAAUBrzPK8PwhsW3dtcfYIFxjQQSuXXqRZIi7E30adN+y7c4XEaA8
        ILkIsgO6oPQJtEaWCjJxdvZ4weoF
X-Google-Smtp-Source: APXvYqx/rwFl+MtYvoLLcqkK+aNtlxTL2ZxgvfhoeTj9iJCmEq1E6xWqdoYOZqa5c48gZrbUu0/hyA==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr3059791wrp.365.1575454160662;
        Wed, 04 Dec 2019 02:09:20 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h17sm7904846wrs.18.2019.12.04.02.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 02:09:19 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:09:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191204100917.GC114697@gmail.com>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Dave Young <dyoung@redhat.com> wrote:

> On 12/04/19 at 03:52pm, Dave Young wrote:
> > Michael Weiser reported he got below error during a kexec rebooting:
> > esrt: Unsupported ESRT version 2904149718861218184.
> > 
> > The ESRT memory stays in EFI boot services data, and it was reserved
> > in kernel via efi_mem_reserve().  The initial purpose of the reservation
> > is to reuse the EFI boot services data across kexec reboot. For example
> > the BGRT image data and some ESRT memory like Michael reported. 
> > 
> > But although the memory is reserved it is not updated in X86 e820 table.
> > And kexec_file_load iterate system ram in io resource list to find places
> > for kernel, initramfs and other stuff. In Michael's case the kexec loaded
> > initramfs overwritten the ESRT memory and then the failure happened.
> 
> s/overwritten/overwrote :)  If need a repost please let me know..

No need, I've edited the typo. :)

Thanks,

	Ingo
