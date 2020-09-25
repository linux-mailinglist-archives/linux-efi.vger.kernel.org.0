Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C37277D29
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIYAuH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 20:50:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:26524 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbgIYAuH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 20:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600995003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtnBkLyI+Qyq5FIQ2Hxjohbm7NrEPqvDOJ8OsQUyGlM=;
        b=eKC6X4dUPmS5t2s6s4D7RFwuEQ6AGpDgqQMJXl+jW7qNeQ3ptkecC6dRyxsyVbkYtyjStO
        FkHizMIXG4uzEq8Ff2uuWa956GONXQlLorBH7BJj5njvVR3nPPsusIYdlYQGWv2hZQQ9Wp
        G1hz68199ta3OqpTTZalSw1Zmucsugs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-zYUWwtA2NoetFDNiXYLt3g-1; Fri, 25 Sep 2020 02:43:30 +0200
X-MC-Unique: zYUWwtA2NoetFDNiXYLt3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGmtYHbejLnCbMxXGWUnYYuXkX3fTOVOqr+KOd9DfRG7Uj2+oER5csuN/k1jFq3Dedd6gSIAi4e/xI7BrPGhhlUIp9iyGeRV4vFH768m32z4iyI85YA+Jd+RZB1Dxl1nv/WOXD5ey3HTd2Gi2YBA85zmlKN1mzDU0QkfTBVR0J+SiEasWFCot3421gt9ikq7Qyd/mOpddHEVtk8KNQPi0T0rDGZuG9Osmn5KNhYAv8XGS6gqOvz3B2KxZqXetFOpH5Zie2EhaDrszVoQoLt/lHYtnd2YNjez9NdfGn+XiwzW6wmNFdW8v9qgYn0+tM12ol4fKZ8oBnRh0YxL/ijvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtnBkLyI+Qyq5FIQ2Hxjohbm7NrEPqvDOJ8OsQUyGlM=;
 b=gzWoFBpWjN8hKiYpJimHD26vVCZgj2p61vmv+b2+Ma4P7wHaL5M+Py9v+dLoC86p5jJRtm3VOxLUxJe0LYd7YouQgZYpZ2SwrGkT4DBXtUyHO27/6W2WJboB/dzMtCcizeZZenCOD9APkwo8jM8KkVgm6PhPYvN9SwrWhlTFBvl6+uQj1LSZcsjOhDQfS/+j4sYIim1SSCydhfrLrW5S5SEKYF9Bs+nrOQ8pmqZ2X/jX5EPm4jdzqmaxzJA4MH5afq1ooEJ9sowNbLJW8wF+l5xCcqTI9Bb7E3NWIZ7Rhp6Gq++Dp2Y7gvbOKzAgC9HJYNKCnUndmCoTDVpcZA6hQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by DB7PR04MB4076.eurprd04.prod.outlook.com (2603:10a6:5:1e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 00:43:27 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::ad09:f3ad:e1a2:868e]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::ad09:f3ad:e1a2:868e%6]) with mapi id 15.20.3391.025; Fri, 25 Sep 2020
 00:43:27 +0000
Date:   Fri, 25 Sep 2020 08:43:15 +0800
From:   joeyli <jlee@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH] efi/efivars: Create efivars mount point in the
 registration of efivars abstraction
Message-ID: <20200925004315.GC31226@linux-l9pv.suse>
References: <20200924082833.12722-1-jlee@suse.com>
 <20200924095157.GA304421@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924095157.GA304421@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HK2PR04CA0071.apcprd04.prod.outlook.com (2603:1096:202:15::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 00:43:24 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4abb10ea-9867-4ef3-3376-08d860ec046b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4076:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40769F9A1B1C09263AF4BCEFA3360@DB7PR04MB4076.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6TMDRG0sxmjxOeOuuej9EFMNBNU6Uk5cotJEjZ0I0AZLZDIUAxygVPyy8pZ5XwEl8BB/r2j8uTwKwU3Y2Ndzp1jj5Don78tOXOncLp4dYnRvAXvA1qtyxJ8WjE6UW19/DRblcJXN6pDY77jI+QlWtfAijgK8qDAkeHUsrYy6NpXaNSAib/dUiWfN2jO/nKIr/XDtH6lBiuIgA9LgKMJjDVbiDOiT1qibGGXzqu30R+T+Bbv0NTDVhBGGaBwvp5BY2urnrWm0wsYiMyGaDQYmGvVoUdA+8gox5r8hsnpLD3kXS1MrvrygzcH77l+nXkWaWJIsvzSs5e3rI+1a5HNLLiRrciYvWFxCiYT4h3tsaT4oEzzpgnR3WcHTIABFWMg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39850400004)(366004)(5660300002)(6666004)(33656002)(2906002)(8886007)(9686003)(956004)(316002)(26005)(55016002)(8676002)(16526019)(1076003)(186003)(7696005)(86362001)(54906003)(52116002)(478600001)(6506007)(8936002)(66556008)(83380400001)(36756003)(4326008)(6916009)(66946007)(66476007)(43062003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rn3SREBYQuYcuaqfNNSs+XTyHMW6RvfbIB+hyu+1jfSV1jiVMFA0zQ8/2j7TeXotEIm3i/IolNSDXEyAtbJp7PYhFAeOCUr9tZyIqf8xc7n2dNRFXu/IKkl/R4cx7/hL2Y+Q9auFbC/IfL6Ef5XxxrviKqc4TqXCgqFjtJ2qVdqFZOch5brMmu0uv7pLqHYTY0Ql0nRpMcsqoRYX1ei0gTo6Y7G4HaueoxO2drxJMuM6mZGzcJElAlvQNtO37oI1g1iZvgAFisO6R5azUkndZBu2E2qNdfrL5+TCHO7nTMK5RZdFY1mOwLVKl22JVptX+TJr+RAfWq26Y8bfJRpTOtzUh4ExCWykG38aWx9yi9ToqNQodLdA3cAlq+zx1xckiea7dCFL0vXB9fQMgwwq4MrnPb0ewnin9XPPpCnT2gC84xIdjd/vPShrvOXkYsW8nHUaGUgaUusyumcR38gdYAWMGLpSnhjKH/wjmkGAewYVG5L89xQ5QFGqKxzVIhkVIkMGw9vX3yV/zE5NZMTXf7A28IpvjOEDN05V/1VkP5UZevlxtEn6YNgHZQ/zZvAVZKDhV83TDXbs+jAJZPdPPZnN18LrqQwRA1t5gfV3TiYj3tquYDFvs3Gv5bpPNHaLsCh7vOALeBR0NARSg057UQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abb10ea-9867-4ef3-3376-08d860ec046b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 00:43:27.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNvzIKnMMOgYILoIyR6NI88b8XEqbDYbFzDROLAryZeQxClHd4qzKy9DM4ypBis7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4076
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Greg,

On Thu, Sep 24, 2020 at 11:51:57AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2020 at 04:28:33PM +0800, Lee, Chun-Yi wrote:
> > This patch moved the logic of creating efivars mount point to the
> > registration of efivars abstraction. It's useful for userland to
> > determine the availability of efivars filesystem by checking the
> > existence of mount point.
> 
> Why not do what all other tools do, and look in /proc/filesystems?
> 
> Why is efivars "special" in this way?  What tool isn't properly looking
> for the filesystem in that way today?
> 

Thanks for your idea. I think that this is good enough for userland
tool to check the availability of efivarfs. Ignore my patch please.

Regards
Joey Lee

> > The 'efivars' platform device be created on generic EFI runtime services
> > platform, so it can be used to determine the availability of efivarfs.
> > But this approach is not available for google gsmi efivars abstraction.
> 
> I do not understand this last sentence, can you try to explain it
> better?
> 
> > This patch be tested on Here on qemu-OVMF and qemu-uboot.
> 
> How about real hardware?  :)
> 
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
> >  drivers/firmware/efi/efi.c  |  7 -------
> >  drivers/firmware/efi/vars.c | 17 +++++++++++++++++
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 3aa07c3b5136..23c11a2a3f4d 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -405,13 +405,6 @@ static int __init efisubsys_init(void)
> >  	if (error)
> >  		goto err_remove_group;
> >  
> > -	/* and the standard mountpoint for efivarfs */
> > -	error = sysfs_create_mount_point(efi_kobj, "efivars");
> > -	if (error) {
> > -		pr_err("efivars: Subsystem registration failed.\n");
> > -		goto err_remove_group;
> > -	}
> > -
> >  	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> >  		efi_debugfs_init();
> >  
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index 973eef234b36..6fa7f288d635 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -1179,6 +1179,8 @@ int efivars_register(struct efivars *efivars,
> >  		     const struct efivar_operations *ops,
> >  		     struct kobject *kobject)
> >  {
> > +	int error;
> > +
> >  	if (down_interruptible(&efivars_lock))
> >  		return -EINTR;
> >  
> > @@ -1191,6 +1193,19 @@ int efivars_register(struct efivars *efivars,
> >  
> >  	up(&efivars_lock);
> >  
> > +	/* and the standard mountpoint for efivarfs */
> > +	if (efi_kobj) {
> 
> Why test for this?  Can it race?
> 
> thanks,
> 
> greg k-h

