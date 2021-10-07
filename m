Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8142579E
	for <lists+linux-efi@lfdr.de>; Thu,  7 Oct 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbhJGQT4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Oct 2021 12:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242668AbhJGQTz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Oct 2021 12:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blEAPOI+nF0owA6gNBYFWO1A41DzHlnw6VWPwMJ/+zM=;
        b=LLyjASjQynccLDiarNREi2sQAC9DThB4k1qYJ5skg1i4+5ygvRuqHc2jDG/er8iJlzTDA3
        pffKrZiKJ/JIoJHJNiCqbZsCJSAranyl6PISiiRnWuuH9Ld64la1aTmyxlX/8g7/qP3yHz
        HZAMyXk7EzPRtkv3ECsehGTguqp0G2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-A_vQo51pPsKW43bdsX0Qzw-1; Thu, 07 Oct 2021 12:17:58 -0400
X-MC-Unique: A_vQo51pPsKW43bdsX0Qzw-1
Received: by mail-wr1-f71.google.com with SMTP id j19-20020adfb313000000b00160a9de13b3so5122111wrd.8
        for <linux-efi@vger.kernel.org>; Thu, 07 Oct 2021 09:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=blEAPOI+nF0owA6gNBYFWO1A41DzHlnw6VWPwMJ/+zM=;
        b=g1AUBx9oijNr3Y4+G+2tMGLcvvBPCzbJuXRH5iiUB1oFvrRIjYbjTqKs9i5nd0Q2rI
         7yVadaXou2eBfly6CZZYWuBSIEak7vpMBnqbqwP+TQqkF0WFikjEf1WhR9GwKEXmkXrq
         DfiyEZCMyhN0ekG2eVgT4BzQZI3Wh3fwKKnM4ysrFGm+ijUijEuTARBa3MwUJH3ecRe/
         MxKV1Ko46mIv/SYFWq8YOvTi7JiPGnabZ270EmuEZKHImnQy5+kjOYyJEZDUc28kqm/2
         8164VkFOuTMh3g+9yP/2GITt8nbMzar8nmLuoD2ACedcB/sB/qWhg4Eg05WAwmQuY4pj
         bhSw==
X-Gm-Message-State: AOAM531Aiv63jUI6A9F4WB/t3cJqcItY7Lexq5IcSlQciMteF17CTDDs
        oYmsOzHk0mfBDb8oqKushX0ZyVKz/13OFjshPEHkh4sAcZuatu35O4Yvh10ZDwwOr8dSpP4nznB
        QKDGezu5VKlSDOVzdpXU2
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr6853074wrr.278.1633623477613;
        Thu, 07 Oct 2021 09:17:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrADigG00ZrKN1jM1AZoSZzR3uxS9vfFO2wr7+DM1JoV/qmvfoFSceMTUWkIHap1R4hsOMQg==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr6853057wrr.278.1633623477478;
        Thu, 07 Oct 2021 09:17:57 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id k17sm9320224wmj.0.2021.10.07.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:17:56 -0700 (PDT)
Date:   Thu, 7 Oct 2021 17:17:54 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] virt: Add sev_secret module to expose
 confidential computing secrets
Message-ID: <YV8dsl+qgbIH6z8F@work-vm>
References: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
 <20211007061838.1381129-5-dovmurik@linux.ibm.com>
 <7e2a4595-3f9c-6d65-34e3-af7c1d6da196@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2a4595-3f9c-6d65-34e3-af7c1d6da196@intel.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Dave Hansen (dave.hansen@intel.com) wrote:
> On 10/6/21 11:18 PM, Dov Murik wrote:
> > +static int sev_secret_map_area(void)
> > +{
> > +	struct sev_secret *s = sev_secret_get();
> > +	struct linux_efi_coco_secret_area *secret_area;
> > +	u32 secret_area_size;
> > +
> > +	if (efi.coco_secret == EFI_INVALID_TABLE_ADDR) {
> > +		pr_err("Secret area address is not available\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	secret_area = memremap(efi.coco_secret, sizeof(*secret_area), MEMREMAP_WB);
> > +	if (secret_area == NULL) {
> > +		pr_err("Could not map secret area header\n");
> > +		return -ENOMEM;
> > +	}
> 
> There doesn't seem to be anything truly SEV-specific in here at all.
> Isn't this more accurately called "efi_secret" or something?  What's to
> prevent Intel or an ARM vendor from implementing this?

I don't think anything; although the last discussion I remember on list
with Intel was that Intel preferred some interface with an ioctl to read
the secrets and stuff.  I'm not quite sure if the attestation/secret
delivery order makes sense with TDX, but if it does, then if you could
persuade someone to standardise on this it would be great.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

