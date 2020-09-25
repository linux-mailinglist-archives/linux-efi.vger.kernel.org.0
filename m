Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5212277D30
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 02:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIYAvL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 20:51:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51664 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgIYAvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 20:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600995066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4rQZHybhRR+OaKoUIPF/tgAe8bpD28i082ctvDrtEHk=;
        b=TSV0jiHlSzf8QurqayQBGDCY/nMjO5WdUanUcfBOGVXoxs8+RqSnQcw5XSkilO1DEDm6qa
        ngkspw7MisLBImJe21B/2TDKo9t7/3AkKaOe7o6NR8bRs1tZvapZOaMIoBt4eRtE6cIom8
        O0BCgTEAm+ZfI2XDSAhUW9plLN/JhSk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-j5hKFu8BOma5GuxEXhzORw-1; Fri, 25 Sep 2020 02:51:05 +0200
X-MC-Unique: j5hKFu8BOma5GuxEXhzORw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdyVLk84hMIlTivgezPgBhj7z+ulK9bUTsrzxKTN7zKfq0iwOAbNb70LlSU18KcDEMfPFLnBFs/kI1KuxyVkBeKNsWisGTBCow3cnkjz5yOu+JXVkpG/gtVBD2iH1Z76VwnMUsrqNiwyoDUew/4e0HlA3Sj5TtfWXzwPojnaLLOixO/A9iaj5+3PiKE2Ffexisz/VdrrglAL7uSqfXhaRNH65xOsH20m9wn93vxobJrAPgt771uOz9g4p0LVqaBUJToOet2KkG2W7Q2U0/YpmdKoPZSodOBsbb9xADeg38EaWmSsDhNsQtx48Cx8ihVilO7Xm8Itf+GL71tzWSxqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rQZHybhRR+OaKoUIPF/tgAe8bpD28i082ctvDrtEHk=;
 b=YuszYivTFueY4dPYw2wIL/D9QCIQcNkcXS3i8prV0UoMv19jL9zTAQIkuL0oWpsUJXWrutjkUrV6m8cicnM6FFk5KoTq/VOYy/JQFR18p7GyDEVusGjgL3r2CHW35BmHX6SmV+d9xACzSyLzONmsnmSa/BezsaD9erYnZLzqmAK9jYSbOz+kZQ/Ub47+gnRLp7itLoiPuPkZHM3PoKZL8QY6IePyA48EjcYO6GqAgexOAXMP7FkTxh3jx/AbAu0YnqAOQrkzo0KekBwLXflMm+kx2H53fmVt52yWvbsgRzNhFqO14wpOwlYGqAc7sO2UzphK2Ikq26IqoENGNJbbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by DB8PR04MB5754.eurprd04.prod.outlook.com (2603:10a6:10:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 00:51:02 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::ad09:f3ad:e1a2:868e]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::ad09:f3ad:e1a2:868e%6]) with mapi id 15.20.3391.025; Fri, 25 Sep 2020
 00:51:02 +0000
Date:   Fri, 25 Sep 2020 08:50:49 +0800
From:   joeyli <jlee@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH] efi/efivars: Create efivars mount point in the
 registration of efivars abstraction
Message-ID: <20200925005049.GD31226@linux-l9pv.suse>
References: <20200924082833.12722-1-jlee@suse.com>
 <CAMj1kXE64kMU7wnMQK+k=0tjaH9OMOrzN86yJPPRkx5Nq8XBqw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE64kMU7wnMQK+k=0tjaH9OMOrzN86yJPPRkx5Nq8XBqw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 00:50:58 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b24bb521-f809-48e0-b1ce-08d860ed1361
X-MS-TrafficTypeDiagnostic: DB8PR04MB5754:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB57548A97BB7AFE7C751E3B2FA3360@DB8PR04MB5754.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXgP3xAHquqQfYziJ6dFF5/fYOCmNux4+sfHgVY/f9m7WS5nJ2FcOc7P3HsO2KCmedMSkvBM5XOskB/Xbm72zahe65xpZ0WTd9bHlbYCmn7WAK4ud6jspNZWfbym/xWFJnNhoxrgjq0D8v9GUZP5TMW+38WS3htH39GUBEcmcdOdusyQmUp2lN+1QuikiuNC1gXIVkk3Wg1iruqq8ZGjWbsh7DFEckYjc4ksjlF5zOKbFk9OOa4KgDno18Ea+O3HHUnxRlf4CToYm3Pz6xCprguXjxBv4v9ASqVrVfPzFrduDhTD0OYbl7qgh7WkRQgxmIiFv7bsfW0u7q6vlTaR0E38vzMEGc5VCecDDsu6O2L50D+7Rl4nvlBMwm9z9Lu7vq5SGxYF213uGlvx2xLDAKMEp5CunhGDWmTa2hYzIoVi1S+gMlhcLE5kh1SngC0jDees+NGCuFKTlbhAT88awnCd1aaFUqu/+S4XZ/TxGjZiu30TFgzJB+dSux9w3a3P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39850400004)(376002)(396003)(6506007)(54906003)(55016002)(2906002)(316002)(4326008)(8886007)(86362001)(5660300002)(66476007)(956004)(66556008)(83380400001)(16526019)(1076003)(186003)(36756003)(8936002)(66946007)(9686003)(478600001)(8676002)(966005)(7696005)(52116002)(26005)(33656002)(6916009)(6666004)(43062003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2xM+jngraaJi+0oSljBsYNBxv12pI27KC8zlCe57UI3mHSv3hErs1wEq755l8T/bHK/WmatzCiTEIT3bjGBJC9WTnlZAZMjsdAzEnkvV7Fn7QaDDJbeajd2g3sqpEraR3J5KnClaqLfFa5dl8SlUVtVXfqJV1Gpc7+iE+NZdqOTSczbkVO75uINSzvD7nbp/ZIO+7mU6OJzEdyzjuDh8PFpfpuxpq5jdN7GsVP1P712yM/Gdg+wpHwak2UgCaokHroz2Zxk0yPi4YCV24d6hCEXDZF84B9ShZ5geba8fnqP3EimFtn7ceWZAYCHJ5UXsHzA8k14UQFrP3K3EYsVYld8qgDr5ImlBT/lNKw/1ZUOLlscQrWgnHSUHi4H1WPLA4OZFWoPAPoiyPAfq+AOA3I0wzoQa6K0KlaiephSpXc6kieV1JAKYokh7uPSSYr14CzBP3rKJmkNmm8IMecLUzuErONuaRoq235/O7cp8a+V85Yi3xpn1xY/UlRx2tpZdsAW5yTtOFgsvpltiWlSA8IzXmFgmOwvXI3VidHkdQlgI9UhW+PUzdv1bEEvttR70YY4KDUvKBGp3Yrp4pBlcHI9BsTEujF+zjfbWOkIcea5aljSrg1QD8UJeApTw/12D+SkZ22KyYpl/I+AzSYvwQQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24bb521-f809-48e0-b1ce-08d860ed1361
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 00:51:02.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWey/jUk/VINgi3XPPzlEwf5rPA3SOQ8f1obcQ2U/2ojcqp/D8shj7BCtGlz0wWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5754
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Thu, Sep 24, 2020 at 12:47:46PM +0200, Ard Biesheuvel wrote:
> On Thu, 24 Sep 2020 at 10:28, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This patch moved the logic of creating efivars mount point to the
> > registration of efivars abstraction. It's useful for userland to
> > determine the availability of efivars filesystem by checking the
> > existence of mount point.
> >
> > The 'efivars' platform device be created on generic EFI runtime services
> > platform, so it can be used to determine the availability of efivarfs.
> > But this approach is not available for google gsmi efivars abstraction.
> >
> > This patch be tested on Here on qemu-OVMF and qemu-uboot.
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Matthias Brugger <mbrugger@suse.com>
> > Cc: Fabian Vogt <fvogt@suse.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arthur Heymans <arthur@aheymans.xyz>
> > Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> 
> I take it this is v3 of [0]? If so, please explain how it deviates
> from v2. If it doesn't deviate from v2, it is better to continue the
> discussion in the other thread.
> 
> For the sake of discussion, it helps to clarify the confusing nomenclature:
> 
> a) 'efivars abstraction' - an internal kernel API that exposes EFI
> variables, and can potentially be backed by an implementation that is
> not EFI based (i.e., Google gsmi)
> 
> b) efivars.ko module, built on top of the efivars abstraction, which
> exposes EFI variables (real ones or gsmi ones) via the deprecated
> sysfs interface
> 
> c) efivarfs filesystem, also built on top of the efivars abstraction,
> which exposes EFI variables (real ones or gsmi ones) via a special
> filesystem independently of sysfs.
> 
> Of course, the sysfs mount point we create for efivarfs is not called
> 'efivarfs' but 'efivars'. The sysfs subdirectory we create for
> efivars.ko is called 'vars'. Sigh.
>

Thanks for your clarification. It's useful to me!
 
> 
> In this patch, you create the mount point for c) based on whether a)
> gets registered (which occurs on systems with EFI Get/SetVariable
> support or GSMI), right? So, to Greg's point, wouldn't it be easier to
> simply check whether efivarfs is listed in /proc/filesystems?
>

Yes, I think that Greg's suggestion is good enough for a userland tool
to detect the availability of efivarfs. You can ignore my patch. 

Thanks for your help!
Joey Lee
 
> It also helps if you could clarify what the actual use case is, rather
> than saying that it is generally useful.
> 
> 
> 
> 
> 
> [0] https://lore.kernel.org/linux-efi/20200825160719.7188-1-jlee@suse.com/
> 
> >  drivers/firmware/efi/efi.c  |  7 -------
> >  drivers/firmware/efi/vars.c | 17 +++++++++++++++++
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 3aa07c3b5136..23c11a2a3f4d 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -405,13 +405,6 @@ static int __init efisubsys_init(void)
> >         if (error)
> >                 goto err_remove_group;
> >
> > -       /* and the standard mountpoint for efivarfs */
> > -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> > -       if (error) {
> > -               pr_err("efivars: Subsystem registration failed.\n");
> > -               goto err_remove_group;
> > -       }
> > -
> >         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> >                 efi_debugfs_init();
> >
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index 973eef234b36..6fa7f288d635 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -1179,6 +1179,8 @@ int efivars_register(struct efivars *efivars,
> >                      const struct efivar_operations *ops,
> >                      struct kobject *kobject)
> >  {
> > +       int error;
> > +
> >         if (down_interruptible(&efivars_lock))
> >                 return -EINTR;
> >
> > @@ -1191,6 +1193,19 @@ int efivars_register(struct efivars *efivars,
> >
> >         up(&efivars_lock);
> >
> > +       /* and the standard mountpoint for efivarfs */
> > +       if (efi_kobj) {
> > +               error = sysfs_create_mount_point(efi_kobj, "efivars");
> > +               if (error) {
> > +                       if (down_interruptible(&efivars_lock))
> > +                               return -EINTR;
> > +                       __efivars = NULL;
> > +                       up(&efivars_lock);
> > +                       pr_err("efivars: Subsystem registration failed.\n");
> > +                       return error;
> > +               }
> > +       }
> > +
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(efivars_register);
> > @@ -1222,6 +1237,8 @@ int efivars_unregister(struct efivars *efivars)
> >
> >         pr_info("Unregistered efivars operations\n");
> >         __efivars = NULL;
> > +       if (efi_kobj)
> > +               sysfs_remove_mount_point(efi_kobj, "efivars");
> >
> >         rv = 0;
> >  out:
> > --
> > 2.16.4
> >

