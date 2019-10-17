Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A627DB94D
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2019 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406312AbfJQVvf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Oct 2019 17:51:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39245 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391375AbfJQVvf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Oct 2019 17:51:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so3506707oia.6;
        Thu, 17 Oct 2019 14:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+J2DBkNb5KYxlKMZS6vCmoqrW/aI/+plqzZy42kR2vY=;
        b=RmjpNHiuaqUQ/FB9rhh0PFeY0Mhw62WfYpKXAATVDCdRh428XNHyZRH0Qh0zSB/b1l
         gCQL+2g2pmBc/I6YauK0Y/UgMvg4z8U55h9p9fXmm7I03m2/JqaBWmct3UPBdR/Hotzk
         JNp/JAMzkEFOBoPZlIgXqYZGjYw8iVtkjPdZhiF6ByoLNEAKqWHBM6McpvXFnjNWYPFO
         ZcSHIkNmqAutcOFouyiA+yN52YKTLrhG1W3sPzENjb19r4AeaB1F+vwVnKe6ZoFFESI9
         n9DOIeI/z8ybS+ABA4bABfSP1I1LB71bJX/9n1sIREYNQn+iJh5d59pbunj+lr2WVC/0
         3Amw==
X-Gm-Message-State: APjAAAX5+mUU0sVpYI5kpMzKnWZ6IyiDxAJz2kHgsf1x6oEobVzBj1OU
        AipQ7Z66goINbnjomtkTCF26sytdd7w5g4J+5i4=
X-Google-Smtp-Source: APXvYqztVvkd2YtllgVC6HXiuMHbmE00RJ4CoT12f9VOgIWI442lqMSocDdFiqwMxrKQA4iPe16ChL0BdMMlhG50NrQ=
X-Received: by 2002:a05:6808:917:: with SMTP id w23mr4924079oih.68.1571349094483;
 Thu, 17 Oct 2019 14:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157118762585.2063440.11707736302358197199.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157118762585.2063440.11707736302358197199.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 23:51:23 +0200
Message-ID: <CAJZ5v0ij_8++vuBZ8xSD6HJYcdM8r_+wxbO-M-iHkNJyvVdB1g@mail.gmail.com>
Subject: Re: [PATCH v7 11/12] acpi/numa/hmat: Register HMAT at device_initcall level
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 16, 2019 at 3:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for registering device-dax instances for accessing EFI
> specific-purpose memory, arrange for the HMAT registration to occur
> later in the init process. Critically HMAT initialization needs to occur
> after e820__reserve_resources_late() which is the point at which the
> iomem resource tree is populated with "Application Reserved"
> (IORES_DESC_APPLICATION_RESERVED). e820__reserve_resources_late()
> happens at subsys_initcall time.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/hmat.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 8f9a28a870b0..4707eb9dd07b 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -748,4 +748,4 @@ static __init int hmat_init(void)
>         acpi_put_table(tbl);
>         return 0;
>  }
> -subsys_initcall(hmat_init);
> +device_initcall(hmat_init);
>
