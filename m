Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9062A278E29
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgIYQUE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 12:20:04 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:38812
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729383AbgIYQUE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Sep 2020 12:20:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXTRyHlF/3LpHjGorQ/rGe0KDJIC3j4gSB19hRFVnipo3DWyOEuBZOFMgLQdzlu5iHcGooRHtsySf0Gn7Q+dMEQDPP2ea2oWvxjruIvrreAA893uM9PWUTbkI63KkvGRN0CR32ogVsoJUWOTOILVvzSg8GDFVaD8ppi+3nfL8WI31W6dhOJeWqmVhRF7xar0x9JpNH1hGwnc6VjqCWz7nzTy3g2egtgzidjr3bcS8CQUFe0ScNS02zFbgl4tBJ0pAsQG4rF/QjZjh9TaydKM/f2Gc6LPoQ8rAD9U29XEicbpYZCDRpZRe3rns7h6O8CUuOtcCyYdovLE0RtuxNcdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fge6147kozbjdnUqwsc5l6sTaiv9MY+KLhzXOoKTsFc=;
 b=LTL8Ev6LtCYiPp/A5yjAd7yRNUYuSl9sH8joKGK6/CDZeA89GVaooHvDZPrASJCYe7+iErTvReGRveL65/X382OodTK8onnITG4f1cKFipPOy13ZqMsnPnIloaDxv0j/CakIue0haFoB3Dk0GmGJVS3mUHsfn+ZOlPCEmGUcEpbjU5VVQmr0sho48bMB9Dg6v964UAUr8RFf7mzaU7u+/6kdhJ1NN2Ib0jOUxTkPeWJtfcsLPIXYdXyJFUFIvd5e9Z/gCRBrflSjTUzPGXjYBZFgw9eOFmgzem/D3pwidwa8imnKWy1rnbSwos2VenYdHmsTYezw/aHf5skbFED2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fge6147kozbjdnUqwsc5l6sTaiv9MY+KLhzXOoKTsFc=;
 b=tYZ8gtbtTthmhPbPcuoWPXjWFRfFNCeZ1exvrrGOm5wN9gLrBFrCobS8BRXdwJWGeU+q+7y+rmbFoSa634kTFNmxCn9w/XYFZafWCuFgJD+dMQ7Gri9AD2JRvhrOI6AxZlCZEb8Hf80NJaFXag/rcEhg6X0hHWj+RrovjS94x3Y=
Authentication-Results: toshiba.co.jp; dkim=none (message not signed)
 header.d=none;toshiba.co.jp; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 16:20:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f%6]) with mapi id 15.20.3412.025; Fri, 25 Sep 2020
 16:20:01 +0000
Date:   Fri, 25 Sep 2020 11:19:40 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli Channabasappa <skoralah@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200925161940.GA21194@yaz-nikka.amd.com>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
 <20200923140512.GJ28545@zn.tnic>
 <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
 <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
 <20200924175023.GN5030@zn.tnic>
 <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 16:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eba0f612-3e00-4751-0bbd-08d8616eda0d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2948975FD7053D19C78FCA8BF8360@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9t+GqiPG1DiYOER/5HSQNqWAP4PUrD5pdNzb1IhE//LJSr0feqfY2IPuhV2cL7ThRg2aFzyVsEV7zUZvsWd/P1VWzxT9EvCUosDJtYhR9yZHcan9wYWarBWRf4LQt2D7SmXtjYSaa38SaJkCH/ULGVJlPmBzSwaVq7PdPzYSYXj8rL8mkNU7+iGYBWYgEq7K2/OweOP43PjFViCu86FxKABXOorm/UifaSoz86ZutgsZGybK4VIrzRCIxJTUh6oK56Pyj/fL0lxIQr4vWqaaYWuVvHSEJ3GOjnRt5oQfPhLSzmvqk21nBVDa5QsYqmL3zWOL5hlx6M0UyJI6pQAuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(6666004)(66946007)(26005)(4326008)(16526019)(7696005)(956004)(52116002)(2906002)(7416002)(44832011)(86362001)(478600001)(33656002)(55016002)(66476007)(66556008)(186003)(6916009)(1076003)(5660300002)(54906003)(316002)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GcAPf/jx1ijQizpHWqUo7pfbFdm6Jynce6IpJX2wbKoqCX5+NDkZtvrJgo4kgnFRREUcvK+PywI7W2tg97YGfQZdmMw9jFGXmDUjDqTKxTwm4kanE/M16rlTjXWzjJUiy3cd1fLV5RgJ5nov/hh3RAWAxPbzy9l5TdQwGZYIq17Y+kkshYKUCNIfCtHh8Rf7k4dcpah7SBZzMQCROJvFPKsx6ckwFqGWubeOf+GS4FojhqCCPhC0Nx3oE2UnnVUTfn5L+bj2UmDG3APJZAn7q13V08UesWGZrzDfTljtiPh4oEBg1IcBsZ0DSR+mE1fBcOHEQ/bQqVmH8R9DwsrDvxLoIJ/VCRV50lspd+1TapoJANW6bsYFL9eYmsExBjCQl/CGD0EAjHb7jpeDiJFjHRL2tjTRViAmOz14hk5CjA5ZXZYcvNOML1xU00lH1Y7BmzyqXDciaoW+ngdGZArn4lpS+iT00zB8KrIjoqhuNtC+k3nFnCph7jVwQ/848k1zwvuAvwtfP8sUbUZeoaQ8DDQ52Lz6/koqa81o6Qm9XlTi5sKozfIWJvbS5lrPjWo9BESs1gTtUtLZR71A7w+jieWEmZ143nD/0HJ1oGexVP3/tuCiKW5FMQ+hoKdy7q6BOc78v7e4VfHGeOVkH1EILA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba0f612-3e00-4751-0bbd-08d8616eda0d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 16:20:01.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amq57A4VqTldNh+83Sw+ujJOrENWcKahdTz59V7no9uxkR9hGq3Dzjvcc3nSt5Zvq7iOD7hOLbwRA0E4K7cgow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 25, 2020 at 09:54:06AM +0900, Punit Agrawal wrote:
> Borislav Petkov <bp@alien8.de> writes:
> 
> > On Thu, Sep 24, 2020 at 12:23:27PM -0500, Smita Koralahalli Channabasappa wrote:
> >> > Even though it's not defined in the UEFI spec, it doesn't mean a
> >> > structure definition cannot be created.
> >
> > Created for what? That structure better have a big fat comment above it, what
> > firmware generates its layout.
> 
> Maybe I could've used a better choice of words - I meant to define a
> structure with meaningful member names to replace the *(ptr + i)
> accesses in the patch.
> 
> The requirement for documenting the record layout doesn't change -
> whether using raw pointer arithmetic vs a structure definition.
> 
> >> > After all, the patch is relying on some guarantee of the meaning of
> >> > the values and their ordering.
> >
> > AFAICT, this looks like an ad-hoc definition and the moment they change
> > it in some future revision, that struct of yours becomes invalid so we'd
> > need to add another one.
> 
> If there's no spec backing the current layout, then it'll indeed be an
> ad-hoc definition of a structure in the kernel. But considering that
> it's part of firmware / OS interface for an important part of the RAS
> story I would hope that the code is based on a spec - having that
> reference included would help maintainability.
> 
> Incompatible changes will indeed break the assumptions in the kernel and
> code will need to be updated - regardless of the choice of kernel
> implementation; pointer arithmetic, structure definition - ad-hoc or
> spec provided.
> 
> Having versioning will allow running older kernels on newer hardware and
> vice versa - but I don't see why that is important only when using a
> structure based access.
>

There is no versioning option for the x86 context info structure in the
UEFI spec, so I don't think there'd be a clean way to include version
information.

The format of the data in the context info is not totally ad-hoc, and it
does follow the UEFI spec. The "Register Array" field is raw data. This
may follow one of the predefined formats in the UEFI spec like the "X64
Register State", etc. Or, in the case of MSR and Memory Mapped
Registers, this is a raw dump of the registers starting from the address
shown in the structure. The two values that can be changed are the
starting address and the array size. These two together provide a window
to the registers. The registers are fixed, so a single context info
struture should include a single contiguous range of registers. Multiple
context info structures can be provided to include registers from
different, non-contiguous ranges.

This patch is checking if an MSR context info structure lines up with
the MCAX register space used on Scalable MCA systems. This register
space is defined in the AMD Processor Programming Reference for various
products. This is considered a hardware feature extension, so the
existing register layout won't change though new registers may be added.
A layout change would require moving to another register space which is
what happened going from legacy MCA (starting at address 0x400) to MCAX
(starting at address 0xC0002000) registers.

The only two things firmware can change are from what address does the
info start and where does the info end. So the implementation-specific
details here are that currently the starting address is MCA_STATUS (in
MCAX space) for a bank and the remaining info includes the other MCA
registers for this bank.

So I think the kernel can be strict with this format, i.e. the two
variables match what we're looking for. This patch already has a check
on the starting address. It should also include a check that "Register
Array Size" is large enough to include all the registers we want to
extract. If the format doesn't match, then we fall back to a raw dump
of the data like we have today.

Or the kernel can be more flexible and try to find the window of
registers based on the starting address. I think this is really
open-ended though.

Does this sound reasonable?

Thanks,
Yazen
