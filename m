Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB783C9EA0
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2019 14:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfJCMgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Oct 2019 08:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfJCMgy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Oct 2019 08:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5FE830BB379;
        Thu,  3 Oct 2019 12:36:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-154.rdu2.redhat.com [10.10.120.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFD4E10018F8;
        Thu,  3 Oct 2019 12:36:43 +0000 (UTC)
Subject: Re: [PATCH] efi/efi_test: require CAP_SYS_ADMIN to open the chardev
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Ivan Hu <ivan.hu@canonical.com>, linux-efi@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20191003100712.31045-1-javierm@redhat.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <7131a0f8-6ef2-c345-f3e2-b892e5f312ed@redhat.com>
Date:   Thu, 3 Oct 2019 14:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191003100712.31045-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 03 Oct 2019 12:36:53 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/03/19 12:07, Javier Martinez Canillas wrote:
> The driver exposes EFI runtime services to user-space through an IOCTL
> interface, calling the EFI services function pointers directly without
> using the efivar API.
> 
> Among other things the driver allows to read and write EFI variables and
> doesn't require CAP_SYS_ADMIN as is the case for the efivar sysfs driver.
> 
> To make sure that unprivileged users won't be able to access the exposed
> EFI runtime services require CAP_SYS_ADMIN to open the character device,
> instead of just relying on the chardev file mode bits to prevent this.
> 
> The main user of this driver is the fwts [0] tool, that already checks if
> the effective user ID is 0 and fails otherwise. So adding the requirement
> won't cause any regression to this tool.
> 
> [0]: https://wiki.ubuntu.com/FirmwareTestSuite/Reference/uefivarinfo
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> 
> ---
> 
> Hello,
> 
> We want to enable this driver in the Fedora kernel for testing purposes.
> 
> Currently the GetVariable() UEFI runtime service is used (through the
> efivar sysfs interface) to test that OVMF is able to enter into SMM.
> 
> But there's a proposal to add a UEFI variable cache outside of SMM, to
> speedup GetVariable() calls. So the plan is to call QueryVariableInfo()
> instead that's also read-only and sufficiently infrequently called that
> is not planned to be cached anytime soon.
> 
> Building the efi_test module will allow us to call this EFI service by
> using the fwts uefivarinfo test. But we are worried that enabling this
> driver could open a new attack vector and lead to unprivileged users
> accessing the exposed EFI services.
> 
> This is also consistent with the efivar driver since it also requires
> the CAP_SYS_ADMIN capability.
> 
> Best regards,
> Javier
> 
>  drivers/firmware/efi/test/efi_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
> index 877745c3aaf..81de7374c42 100644
> --- a/drivers/firmware/efi/test/efi_test.c
> +++ b/drivers/firmware/efi/test/efi_test.c
> @@ -717,6 +717,8 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
>  
>  static int efi_test_open(struct inode *inode, struct file *file)
>  {
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
>  	/*
>  	 * nothing special to do here
>  	 * We do accept multiple open files at the same time as we
> 

Looks consistent with other capable(CAP_SYS_ADMIN) checks in
drivers/firmware/efi/.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
