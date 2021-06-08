Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6B3A04A3
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 21:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhFHTu3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 15:50:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229845AbhFHTu1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 15:50:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158JhxIc159290;
        Tue, 8 Jun 2021 15:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T+GhJj+B5oDuExla5uOSQKs7oMeENVFPj0/O7uKmuQ4=;
 b=B8GGq14uwkHma4SbtwyYSwGQL2tsvAYufU3aBN2TFKiIUbW3V+62fctihqPEsDoaPDIr
 z76AAUI41R8iAJB1ylAR5AxsveBJr5T+NK7fQe4wpyY9qJn+TL1jJJFlV6QRZ2sRb0ZR
 14/nRGTlCsXp0guHrcAKa6F0abM32atIw0lkQu9sHGwpqMUpPA1LHiaI1NuZxTNqJG17
 PmpNxoEXwa4sdqi9wPX4nE8hsgcCmuD+wfIwgGiPuRtqlAAy9gfZULcLLRCaXENKeXmH
 4boebzDKa7uo19Z/EYYVFJkfckK2IJShs6kdbNdPZ+Y7OS0WsM01FUwsEU5DDAimzW5N +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 392eycg2us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 15:48:20 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 158JiQSa160686;
        Tue, 8 Jun 2021 15:48:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 392eycg2tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 15:48:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 158JhX88029559;
        Tue, 8 Jun 2021 19:48:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3900w8hq56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 19:48:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 158JlQwr32440806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 19:47:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 307885204E;
        Tue,  8 Jun 2021 19:48:15 +0000 (GMT)
Received: from [9.160.30.75] (unknown [9.160.30.75])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5C17252050;
        Tue,  8 Jun 2021 19:48:10 +0000 (GMT)
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
To:     jejb@linux.ibm.com, Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
 <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
 <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
 <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
 <YKuXI9TUBa3sjY3e@work-vm>
 <81aa5e70-ab94-393c-92e1-fdac14708aff@linux.intel.com>
 <ddfbcb36b928f6b0a1e9b3262b55cce48a3c326c.camel@linux.ibm.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <d5e352ab-8713-7864-8bf4-a8699cd4f607@linux.ibm.com>
Date:   Tue, 8 Jun 2021 22:48:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ddfbcb36b928f6b0a1e9b3262b55cce48a3c326c.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G5BmeTCPp5iaee8eR5_kLh98SBkJe_P1
X-Proofpoint-ORIG-GUID: GPPg4mzJsCpt2ASXNYNNzOqhLw53CbbX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_14:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080126
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 24/05/2021 20:12, James Bottomley wrote:
> On Mon, 2021-05-24 at 09:31 -0700, Andi Kleen wrote:
>> On 5/24/2021 5:08 AM, Dr. David Alan Gilbert wrote:
>>> * Andi K
>>> Is there any way we could merge these two so that the TDX/SVKL
>>> would look similar to SEV/ES to userspace?  If we needed some
>>> initrd glue here for luks it would be great if we could have one
>>> piece of glue. [I'm not sure if the numbering/naming of the
>>> secrets, and their format are defined in the same way]
>> Maybe. There might well be differences in the contents as you say.
>> So far SVKL doesn't really exist yet,  initially there will be the
>> initrd based agents. The agents definitely will need to know about
>> TDX.
>>> Do you think the ioctl is preferable to read+ftruncate/unlink ?
>>> And if it was an ioctl, again could we get some standardisation
>>> here - i.e. maybe a /dev/confguest with a CONF_COMP_GET_KEY etc ?
>>
>> The advantage of the two ioctls is that they are very simple.
>> Anything with a file system would be a lot more complicated. For
>> security related code simplicity is a virtue.
> 
> This RFC contained the FS code.  In size terms its very comparable to
> your ioctl.
> 
>> Also since it's a really simple read and clear model I don't expect
>> the value to be used widely, since it will be gone after boot
>> anyways.
> 
> Enumeration looks to be problematic with your interface ... what are
> you supposed to do, keep calling ACPI_SVKL_GET_KEY_INFO on an advancing
> index until it gives you an error and then try to work out what key
> you're interested in by one of its numeric properties?
> 
> I think a GUIDed structure actually helps here because we don't have to
> have someone assign, say, u16 types to keys we're interested in and the
> filesystem does all the enumeration for us.  It also means new use
> cases can simply expand the properties without waiting for any
> internals to catch up.
> 


Following the discussion here (and in various other meetings), the next
version of this patch series will keep the securityfs interface but will
introduce an unlink operation for the securityfs entries that will do
the following:

1. Remove the file entry from the securityfs dir

2. Overwrite the secret data memory (memzero_explicit)

3. Overwrite the GUID in the data memory with some invalid GUID
(ffffffff-ffff-.... ?), so that if the module is removed and loaded
again, the securityfs dir will not contain this entry (we'll ignore
these invalid GUIDs in the iteration).



Dov
