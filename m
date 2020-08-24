Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4E24FE80
	for <lists+linux-efi@lfdr.de>; Mon, 24 Aug 2020 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHXNDu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Aug 2020 09:03:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32686 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728000AbgHXNDq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Aug 2020 09:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1598274222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXVD1RfIwl31t5YQOgoHAX9cxnAs1egVfHN4qtPaxBk=;
        b=m5Ec/S25s5zAHa1IP6m1E/FtWPI6yQbgIQPnxvfkCyArWhYPMYkoG2QdlhlASlqpHWCFJI
        RdTv6g1OrIOmS5ochoogP0hewKwq8dZ91xfaoOvnxcWrWRltiT3GZdeneXa7UQlcv6zQaH
        vVJiwX9P3JG8paKnd+GQgfdBRyuRehQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18--QGSovW0O0GzoX2vUYQ6Sw-1; Mon, 24 Aug 2020 15:03:41 +0200
X-MC-Unique: -QGSovW0O0GzoX2vUYQ6Sw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIf4ekyLyAtPIM9jM4iu4WNQJNUMcfc2pYa5ckdytG3/FyLYLEL7EU8hoVa0rbZ65QifKd/oQSkYzSw9L6ZxSjTQKwGnElo3rQLNv/dfvdJXq4WkdoufDmjiN2qPa6g6dQ66SVESzYLL6xKPwTjuD+oKko1C2UMN3dastOhB9P4eczRiNkCop9ZhYCLDgn0Se8W3jneltI8jE7QonFYec6X/Q9qqXWO8ioN6vzsg35RcLSPP3ZjWmfLObzemkKO+boaVmZv/9LfnmNLFfMrk0yRmLArRjc/UNCRfYCVzHef4kAAuBW1jMRiancZNMtHW1+qQmm+Gkx7sT71KqO5uCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXVD1RfIwl31t5YQOgoHAX9cxnAs1egVfHN4qtPaxBk=;
 b=hspl9nS1Eg7OEfFO6TPOJ6PRVcLAz7scmJEcVNlBMioxGGW2hR7VfbFbq7jU5NIpXLhohXoxr/MnGtfhVzajgg4G4III9J32AM2Bq2BoXMaB7/kLG4EUV+PGHDvuRMO1whsujyMKOmTfDbwug9j3KV58xMtNJFSzDV+KboDZi7ophoxkOPRmKM5tBRdhbbpWo7tgGnIMuBVjniR804LwAeqyzdJTvkl+4NWGqtpcuft3IPsONz9QA4faOkITiwPg1SYYoKxNfXcL6ILDBUgA0jnASC5B4KYwbijcfyi71QAdoL3InnDFtcWwwl4rjEkp1UN75WniZnkERoZkigQfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR0401MB2238.eurprd04.prod.outlook.com (2603:10a6:800:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 13:03:39 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::c8e6:73d6:6e2e:9adf%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 13:03:39 +0000
Date:   Mon, 24 Aug 2020 21:03:20 +0800
From:   joeyli <jlee@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi/efivars: create efivars mount point when get
 variable services are available
Message-ID: <20200824130320.GT7501@linux-l9pv.suse>
References: <20200819092838.11290-1-jlee@suse.com>
 <CAMj1kXGx=34tqSWqDUbfJ5WAB-3rWhBc1xsh2-kk2pQgcnfbRQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGx=34tqSWqDUbfJ5WAB-3rWhBc1xsh2-kk2pQgcnfbRQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HK2PR06CA0018.apcprd06.prod.outlook.com (2603:1096:202:2e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 13:03:35 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38fa6730-412a-4895-0094-08d8482e1eb1
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2238:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2238A6FDBFEB808F2B209CF0A3560@VI1PR0401MB2238.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOOmVIpIHyKQ8hWJpxkonH9POajocomYv0DIzdjdYrXghWGERBM3yEYe7N82///M5w+wXfk4T7Zyr7Nzx4696l75IMSE3LUCwxDKOcExXJ0BgJ75nBIuFeK2DOlk37tQdVakPiwzMennrIj50g12Ba6alR0GgUL9yCM41qYyRVNZgm5AfRK5c0NZwWFjXyW4V4xNuNkqP5B4kTWmYrFIa+xo9Fn/WylQ176vbhDL6hBYbzPGlc/rsOb1MencKfjSXF18GYvvasCzx/FYnu3ahB1oG7Y0XfWc5U/mGBlA33dh3H4JtXMKrU8KWwXhB0DiFGOGcIBgYTk/smd2RZbwmsHKFV+CmSHImrp/eNydbsJGN5Un1eT9ld8rXOS2fYPW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(86362001)(6666004)(83380400001)(54906003)(7696005)(316002)(4326008)(9686003)(33656002)(8886007)(6506007)(6916009)(2906002)(52116002)(956004)(55016002)(478600001)(8936002)(1076003)(186003)(16526019)(26005)(66946007)(8676002)(5660300002)(36756003)(66476007)(66556008)(43062003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NSC5+kxMATxikrcJ9rNgVtwFMNhLWIexUu7tvfXLkNqOlTni9Jl6XZDibM7yh8Z2hRKwsxcAo//+dZfLFQbqyRm58+1JllGcZ9WlideM0yzVor9ClcyDqzyOLQyWxW8RkXYEjQnK9bAhyG3vexO5EPNtnWeocbpw2ew3B12RW+tTKL++YH+mZmO2Idc9EI4vZntizwUNiEwEuJ2rJogWKZHb7GNatu9oT1PUAtl8lQBAgyLtNsZLiDnDh3QdInwycQJQ8BoqDHqoP0R1Gmz/wQScws70E/7A2mVRslwLSBmeyupuX5q+HPjGMmHtC9ZtKqWwcbsP0qCuR44CeIZQC0ktQRiBNxMrAkRLnxbd7itMeJDuDZkfidg/rl9NywujSytiwdsiYBEmmQuHLoQXIHncHoNvLRQG+wSq0lAb5igikDxLyH0fLYaMywBNAmSASnP0LoNup8JpQlyp9GS+p6c5UEByKB1AxjtTwDcZ2Ga476ssrGJ7X9HHua5s72U782fMPjknqHo9PJxFRpIc/OC5rKhuc9mnW9y7qD9/r16sec+hUz5OuUeCWmzIdBG1iECvooEuwGIl9vrkkewaVbLMcMd+vHA+2/J81hn3OlA4m4BNQUIAotQdoR9CVaQNGeqkAePK9KCX4O46k9rdhQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fa6730-412a-4895-0094-08d8482e1eb1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 13:03:39.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzUS/rP692PalD5ogX+95LjZXRedqFn1crPpHaUtQQ7Fyj+ovTfawj/lrUBlvj4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2238
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Thu, Aug 20, 2020 at 11:30:27AM +0200, Ard Biesheuvel wrote:
> On Wed, 19 Aug 2020 at 11:28, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > The efivars filesystem depends on GetVariable or GetNextVariable EFI
> > runtime services. So the /sys/firmware/efi/efivars does not need to be
> > created when GetVariable and GetNextVariable are not available.
> >
> > It is useful for userland to determine the availability of efivars
> > filesystem.
> >
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Hello Joey,
> 
> This is not the right check to perform here: the efivarfs code could
> be instantiated using a different efivars abstraction, so whether the
> RT services are implemented is not entirely relevant.
> 
> Please look at commit f88814cc2578c121e6edef686365036db72af0ed
> ("efi/efivars: Expose RT service availability via efivars
> abstraction") for an explanation of the underlying issue, and update
> your patch accordingly.
>

Thanks for youre review! I will look at f88814cc257 and change my
patch for v2.

Joey Lee
 
> 
> > ---
> >  drivers/firmware/efi/efi.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index fdd1db025dbf..929fbf4dfd5d 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -404,11 +404,14 @@ static int __init efisubsys_init(void)
> >         if (error)
> >                 goto err_remove_group;
> >
> > -       /* and the standard mountpoint for efivarfs */
> > -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> > -       if (error) {
> > -               pr_err("efivars: Subsystem registration failed.\n");
> > -               goto err_remove_group;
> > +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
> > +                                     EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
> > +               /* and the standard mountpoint for efivarfs */
> > +               error = sysfs_create_mount_point(efi_kobj, "efivars");
> > +               if (error) {
> > +                       pr_err("efivars: Subsystem registration failed.\n");
> > +                       goto err_remove_group;
> > +               }
> >         }
> >
> >         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> > --
> > 2.16.4
> >

