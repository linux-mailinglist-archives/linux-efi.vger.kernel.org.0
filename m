Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D1DC0D8
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2019 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409696AbfJRJZZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Oct 2019 05:25:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35423 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409691AbfJRJZZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Oct 2019 05:25:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id z6so4414145otb.2;
        Fri, 18 Oct 2019 02:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLZQsTX5Rvgnn5vL+Xt61Ar3lBtnc8eFFCcH3/lKWdo=;
        b=HmIKM1zdPNKjl9agxduwc8eusnivKiEXsQHZWrBqOo7++PkpaJWm2juZMSRmrWn53j
         ehC37p5MDPl37RnN5x0riZ4Yjccc8vuXkGK/+Vdn+Y9pINCv+sEXprguM0iOYN4aTkiX
         pu0GkZXEJJvAlZmHEMEK6Rz7aAdJV/DwX0yzJAgB5SNHpAzkT4sD2f1Sehw+HrbtQnHw
         sAlsLIsdM/mdlzuSpAIi+YIFBtVXJ/g8HPHp0UTCFkx1sTsx3mYciZ2vUQaLeE6QS6/u
         CT/ATDoUK9jGnCYy/qBpmVuTqP0i+HrrQJLRkBKIRdSCr28hDtGqbbKLq5WYeUoq77Gs
         JC3g==
X-Gm-Message-State: APjAAAXPRMcVOHn1iHfadRo8SuUaUruo90Um/4wblRATmbFduIC3BC7g
        FiZSEIqzxLVj8CnVwuiL/RUpkW//vHqYvPbutqE=
X-Google-Smtp-Source: APXvYqz39QtuEfi070UhPNWBHg9t+xSrdCWlQ70T7u8LNX/2ChPK/tcarZZe5ZN2MTvNYCCWIcPJAED04XWic0o7MAg=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr6986127oth.266.1571390724530;
 Fri, 18 Oct 2019 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157118757175.2063440.9248947575330904096.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157118757175.2063440.9248947575330904096.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 11:25:13 +0200
Message-ID: <CAJZ5v0i-hhasNCD6Ur8VLfrkc+4GOeNXXX_ZNFZjcY6F51ciSQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] acpi/numa: Establish a new drivers/acpi/numa/ directory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

 On Wed, Oct 16, 2019 at 3:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Currently hmat.c lives under an "hmat" directory which does not enhance
> the description of the file. The initial motivation for giving hmat.c
> its own directory was to delineate it as mm functionality in contrast to
> ACPI device driver functionality.
>
> As ACPI continues to play an increasing role in conveying
> memory location and performance topology information to the OS take the
> opportunity to co-locate these NUMA relevant tables in a combined
> directory.
>
> numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> hmat.c.
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Please note that https://patchwork.kernel.org/patch/11078171/ is being
pushed to Linus (it is overdue anyway), so if it is pulled, there will
be a merge conflict with this patch.

Respin maybe?
