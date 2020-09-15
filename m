Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A326A0BA
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgIOIYh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 04:24:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42312 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIOIQD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:03 -0400
Received: from zn.tnic (p200300ec2f0e42005bd5729a6296255f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:5bd5:729a:6296:255f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E2721EC058C;
        Tue, 15 Sep 2020 10:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600157716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yEJCfXwRj3yq0x1l28tMtuPd1vDO0s2J9nk983qf9F0=;
        b=OoPBYUiCysYxcynou0G8+BD+lVSt+BH4l01auVyJjRXkXNcuz+g9OrEtK3u9E1pH+Wa1NF
        1rXMIEuOkLoPDF1LdzHmvbOe/QmjpelvDafamvArRTUj0DIzP6l+49cGrIisCTKSGYYnXG
        wlZkhrnXs+6tyvvnuK00dbdNBw5cUxE=
Date:   Tue, 15 Sep 2020 10:15:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 1/2] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200915081514.GB14436@zn.tnic>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200903234531.162484-2-Smita.KoralahalliChannabasappa@amd.com>
 <20200914153024.GC680@zn.tnic>
 <a28aa613-8353-0052-31f6-34bc733abf59@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a28aa613-8353-0052-31f6-34bc733abf59@amd.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 14, 2020 at 04:16:10PM -0500, Smita Koralahalli Channabasappa wrote:
> May be something like apei_smca_report_x86_error? Or probably an additional
> SMCA-specific function call inside this generic APEI and MCA function call?

apei_smca_report_x86_error() sounds ok. If there's need for any
additional MCA handling from BERT, then that can be extended/refactored
then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
