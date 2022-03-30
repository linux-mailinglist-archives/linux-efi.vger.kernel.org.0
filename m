Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95664EBAA4
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 08:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiC3GOR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiC3GOP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 02:14:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E42344C7;
        Tue, 29 Mar 2022 23:12:30 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U4uadu035415;
        Wed, 30 Mar 2022 06:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2p+VfMA5uwCNYrlHBOCjlIzvMpTMcxZ4c82raGuzbWE=;
 b=COYcBlOBPQtNJt9mJEpxPIghjADJKZ7w4oYjykadGnc86iKz2McfzFzmrWy9brCAbJkb
 0VJjhwEBRF4QYni4Z2TM7KTF/BVxCOf6MNRhkXfIRdfOaN2AicyIFzkYvEvBl1glOirs
 FTJvLf7aVnfv2AnaDi+PNtOHBNstDA+nk8bg2qLb+WQS1A45RM3UkmeND4VYYlOl13rr
 GTtensacYaGi5N16kMe6Rv+TQyvhRilcVuCqZmE0zlQqOCRckMGnJsrfzJaey4CBJgcR
 cLJrLdsJpg26PptyUNuoyNOgyMQsmx8/UrbBzWim+AMKvoqKt5bulqHDImE66X5oS3TL Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40c8x594-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 06:12:02 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22U65l7I007664;
        Wed, 30 Mar 2022 06:12:01 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40c8x58v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 06:12:01 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22U69LdH032360;
        Wed, 30 Mar 2022 06:12:00 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3f1tfa31mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 06:12:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22U6Bxf022741458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 06:11:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5220112062;
        Wed, 30 Mar 2022 06:11:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 703DE112067;
        Wed, 30 Mar 2022 06:11:55 +0000 (GMT)
Received: from [9.160.79.229] (unknown [9.160.79.229])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Mar 2022 06:11:55 +0000 (GMT)
Message-ID: <247080bd-fef5-c892-7753-f9b7cf650166@linux.ibm.com>
Date:   Wed, 30 Mar 2022 09:11:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 0/4] Allow guest access to EFI confidential computing
 secret area
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <YjydSNnG6EJ1KWx0@zn.tnic>
 <f2fb7553-0313-6393-c93c-2bb6619086dc@linux.ibm.com>
 <YkNQNzNa02Sndu+q@zn.tnic>
 <7696ba46-91c7-7119-bd68-b3521459cf37@linux.ibm.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <7696ba46-91c7-7119-bd68-b3521459cf37@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hwm7FFhPyN3fkPL7ktrNEzWHOT8Cvb0b
X-Proofpoint-GUID: YrtY1ADfDzcA_fuzCXaHOyAuxmCX6GwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_02,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 29/03/2022 23:28, Dov Murik wrote:
> 
> 
> On 29/03/2022 21:30, Borislav Petkov wrote:
> 
>>
>> So now that I think of it, it would be even nicer if the fact whether
>> guest debugging is allowed, were available to the guest *very early*
>> during boot. Because I think the most important cases where you'd want
>> to singlestep a SEV* guest with the qemu gdbstub is early guest kernel
>> boot code. So it would be cool if we'd have access to the debugging
>> setting that early.
>>
>> Lemme have a look at your patches in detail to get an idea what's
>> happening there.
> 

After a night's sleep I figured out that an SEV guest cannot tell if a
value it's reading was (a) encrypted by the host using
KVM_SEV_LAUNCH_UPDATE_DATA, or (b) added using secret injection using
KVM_SEV_LAUNCH_SECRET.

The only difference is that if the host is using
KVM_SEV_LAUNCH_UPDATE_DATA, then it changes the measurement.  But maybe
for debugging scenarios we (= Guest Owner) don't care about the
measurement being correct.

If that's the case, we don't need a secure channel and secret injection.
You can use a simple "sev=debug" (or whatever) in the kernel
command-line to indicate your needs.


Did I miss something?


-Dov

