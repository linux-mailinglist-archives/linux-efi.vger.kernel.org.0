Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF7178AF2
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 07:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgCDGxH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 01:53:07 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:58699 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgCDGxH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 01:53:07 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Wed,  4 Mar 2020 06:50:59 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 4 Mar 2020 06:51:32 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 4 Mar 2020 06:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efs5tIEx1fgONgPwRSNP0QjUBM8YFiiQf63F/zTdqz5klzuIyAby2HnvIwZh+oMJlh9/uIomJzjzzK3T3R9z8cQXiBM/bTYVmIGYvX+g/t4NHVrNGuQTxDGDo9mxhOZGQWziPB46Ke5Ziv/bPCggsLUn1+eUQCE4sArPohPStlqFd1ZYQoB1L6XlBOqWTP0PsWJuWVUkXG5vFbGHDvXESqCqewb9Fkxa45zj+EclICL5cPamAXalxjmYUyhQTVUgJJwrmFtzdXU9hKBdBJfTmHSPSr+uv/5p9MCibI3E2vk6WH8hWQcRgV3lHAIOwJ5LJBggwnprbPKi+BTYCz2P+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09S13ERhUUn9gu/SfFMi0k0vrtRBkbIaJyf749v8W84=;
 b=Rrfc0rk5WyFUR/Y8nuBtUYrByA33oaVSUjHDrj99LZbofwOxu030XNmgfiLPxm64JT/j4CBWUPLPew7SRDmG29ZAEe/pNyzAXho1BHrV7S2u3yRgpFu2eZYqm2sB2NHYYRFHTCc+hngvRTmhe8Vy4ZnpzEoEbaiuYEsSzJyMnFfc4XXtDNPkAGQCtaeE0XZ+c7K9jDK2h9L88EgGSdxDvP6djxL3ouYovb8zwwruWCjFp0kku4BAB2sjDg7GrSCqC1kve06nH1vuc326oiRHkrH/6G1Dod7qZZt3C6Bls1Baxd5HAe928nsVrPh4o+bHIx9XvQWA8e6udqqpneDQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
Received: from CH2PR18MB3240.namprd18.prod.outlook.com (2603:10b6:610:2d::27)
 by CH2PR18MB3351.namprd18.prod.outlook.com (2603:10b6:610:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 06:51:31 +0000
Received: from CH2PR18MB3240.namprd18.prod.outlook.com
 ([fe80::b4b0:7004:b49e:a63]) by CH2PR18MB3240.namprd18.prod.outlook.com
 ([fe80::b4b0:7004:b49e:a63%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 06:51:31 +0000
Date:   Wed, 4 Mar 2020 14:51:22 +0800
From:   joeyli <jlee@suse.com>
To:     Vladis Dronov <vdronov@redhat.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
Message-ID: <20200304065122.GK16878@linux-l9pv.suse>
References: <20200303085528.27658-1-vdronov@redhat.com>
 <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <1980156503.12639063.1583230452485.JavaMail.zimbra@redhat.com>
 <358842423.12639861.1583231098544.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <358842423.12639861.1583231098544.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To CH2PR18MB3240.namprd18.prod.outlook.com
 (2603:10b6:610:2d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (60.251.47.115) by HK2PR03CA0058.apcprd03.prod.outlook.com (2603:1096:202:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Wed, 4 Mar 2020 06:51:29 +0000
X-Originating-IP: [60.251.47.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f71b63c-e37c-4696-b892-08d7c0087846
X-MS-TrafficTypeDiagnostic: CH2PR18MB3351:
X-Microsoft-Antispam-PRVS: <CH2PR18MB3351025DCB5604F1138383DCA3E50@CH2PR18MB3351.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(52116002)(9686003)(55016002)(33656002)(8886007)(36756003)(7696005)(1076003)(5660300002)(6666004)(956004)(66946007)(6506007)(6916009)(16526019)(66556008)(66476007)(316002)(478600001)(54906003)(186003)(4326008)(55236004)(81166006)(81156014)(26005)(86362001)(2906002)(8676002)(8936002)(43062003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3351;H:CH2PR18MB3240.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5tYLrL/mVfnamlq74XVIFpZ0um/50b9L4o5JNV1vkW/1O1nB0bh0ffkEcRIp7HfXNCFsSU3WRORyraUDXk+PCv444HqZ13NEN3k9WGauXd1n63iTyW1iC7cCHWLHl6zbEXiqYQLKttajFovO1PvmmCug61WXb13hPhKMMfpu+QBycrdFiTXp/FayaZn+Kv2DPP+oMVqstC8+vnBb/CSbwKEiTpMdmosOUdnQ4CtXbxlpCnd/zlTUSbXyYRhMFNzbxlp76Xx1vXfMKe7aJO4AfUdYKlE4mnmCGG9Ch0pKQPfx88YBEm65O6cQs06DtLZ0hlLOrRvDF8s//t0r3cI7lNmbArBECcGv8i6+E51sGspEJrIiQbbUUeP8yAntOLKHkFRAcs1LmAdONwAT5UJbBaVAWLLU4Sqc3qvtWS5ig54dv7PnUpqnc3o3rzKAtKzDdCi+gcFXKMKrzBJ1s4RqQvQ6J2qd0uv4bflx4DhQ3MMWnq5w6dlRB89JOZkF8c5
X-MS-Exchange-AntiSpam-MessageData: oLy1pVK6zaNsWQ54lD1MCOQnvH5LwhzzVnLLux8FDhCKsq1qVMGzJRuqlAM8bdqA3O3WXPlqK1jAPHQdCyS5CDmpyqn4dVNi72EQNnUzNdVkqaA6bw5BzgnXtLdJO5OpX7f3qMLKcG+6hYEQ2/G8sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f71b63c-e37c-4696-b892-08d7c0087846
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 06:51:31.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3HNTQGO/bAB5IjnhnNsBUVU5YNFgn2xthlibAk16rOsnYBu1eFJ9I9Z9vMr/oUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3351
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi all,

On Tue, Mar 03, 2020 at 05:24:58AM -0500, Vladis Dronov wrote:
> Hello, Ard, all,
> 
> > > Wouldn't it be easier to pass a var_data_size stack variable into
> > > efivar_entry_get(), and only update the value in 'var' if it is <=
> > > 1024?
> > > 
> > 
> > I was thinking about this approach, but this way we still do not protect
> > var from a concurrent access. For example, efivar_data_read() can race
> > with itself:
> 
> Oh, indeed, this race is not possible the way you sugget with a var_data_size
> stack variable. Unfortunately, AFAIU, the read/write race stays:
>  
> > ... efivar read functions still can race with the write function
> > efivar_store_raw(). Surely, the race window is much smaller but it is there.
> > I strongly believe we need to protect all data accesses here with a lock.
>

Looks that kernel uses EFI protocol to query variable everytime, then
why should kernel keeps a copy of variable data size, data and attributes in
memory? It makes sense to keep VariableName and VendorGuid, but why data?

The efi_variable can be used to interactive with userland. But we do not
need to keep a data copy in efi_variable with efivar_entry. e.g. The
efivarfs_file_read() allocates a buffer for reading variable instead
of using efi_variable->Data. 

Regards
Joey Lee
