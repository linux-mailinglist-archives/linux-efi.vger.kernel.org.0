Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5546C4A
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jun 2019 00:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfFNWWj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jun 2019 18:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfFNWWi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jun 2019 18:22:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EMLkLV109163
        for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2019 18:22:37 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4k3tjwev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 14 Jun 2019 18:22:37 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 14 Jun 2019 23:22:36 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 23:22:31 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EMMUt628836136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 22:22:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 534F6B20B4;
        Fri, 14 Jun 2019 22:22:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E768FB20AE;
        Fri, 14 Jun 2019 22:22:28 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.231.131])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 22:22:28 +0000 (GMT)
Subject: Re: [PATCH v3 1/3] powerpc/powernv: Add OPAL API interface to get
 secureboot state
To:     Daniel Axtens <dja@axtens.net>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>
References: <1560198837-18857-1-git-send-email-nayna@linux.ibm.com>
 <1560198837-18857-2-git-send-email-nayna@linux.ibm.com>
 <87ftofpbth.fsf@dja-thinkpad.axtens.net>
 <eaa37bd0-a77d-d70a-feb5-c0e73ce231bf@linux.vnet.ibm.com>
 <87d0jipfr9.fsf@dja-thinkpad.axtens.net>
From:   Nayna <nayna@linux.vnet.ibm.com>
Date:   Fri, 14 Jun 2019 18:22:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87d0jipfr9.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19061422-0064-0000-0000-000003EE45E4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011263; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01218034; UDB=6.00640562; IPR=6.00999155;
 MB=3.00027315; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-14 22:22:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061422-0065-0000-0000-00003DE4DAA6
Message-Id: <b2cedb05-6373-b357-f35c-bc112c78a6fc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140175
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 06/12/2019 07:04 PM, Daniel Axtens wrote:
> Hi Nayna,
>
>>>> Since OPAL can support different types of backend which can vary in the
>>>> variable interpretation, a new OPAL API call named OPAL_SECVAR_BACKEND, is
>>>> added to retrieve the supported backend version. This helps the consumer
>>>> to know how to interpret the variable.
>>>>
>>> (Firstly, apologies that I haven't got around to asking about this yet!)
>>>
>>> Are pluggable/versioned backend a good idea?
>>>
>>> There are a few things that worry me about the idea:
>>>
>>>    - It adds complexity in crypto (or crypto-adjacent) code, and that
>>>      increases the likelihood that we'll accidentally add a bug with bad
>>>      consequences.
>> Sorry, I think I am not clear on what exactly you mean here.Can you
>> please elaborate or give specifics ?
> Cryptosystems with greater flexibility can have new kinds of
> vulnerabilities arise from the greater complexity. The first sort of
> thing that comes to mind is a downgrade attack like from TLS. I think
> you're protected from this because the mode cannot be negotiatied at run
> time, but in general it's security sensitive code so I'd like it to be
> as simple as possible.
>
>>>    - If we are worried about a long-term-future change to how secure-boot
>>>      works, would it be better to just add more get/set calls to opal at
>>>      the point at which we actually implement the new system?
>> The intention is to avoid to re-implement the key/value interface for
>> each scheme. Do you mean to deprecate the old APIs and add new APIs with
>> every scheme ?
> Yes, because I expect the scheme would change very, very rarely.

So, the design is not making the assumption that a particular scheme 
will change often. It is just allowing the flexibility for addition of 
new schemes or enhancements if needed.

>
>>>    - Under what circumstances would would we change the kernel-visible
>>>      behaviour of skiboot? Are we expecting to change the behaviour,
>>>      content or names of the variables in future? Otherwise the only
>>>      relevant change I can think of is a change to hardware platforms, and
>>>      I'm not sure how a change in hardware would lead to change in
>>>      behaviour in the kernel. Wouldn't Skiboot hide h/w differences?
>> Backends are intended to be an agreement for firmware, kernel and
>> userspace on what the format of variables are, what variables should be
>> expected, how they should be signed, etc. Though we don't expect it to
>> happen very often, we want to anticipate possible changes in the
>> firmware which may affect the kernel such as new features, support of
>> new authentication mechanisms, addition of new variables. Corresponding
>> skiboot patches are on -
>> https://lists.ozlabs.org/pipermail/skiboot/2019-June/014641.html
> I still feel like this is holding onto ongoing complexity for very
> little gain, but perhaps this is because I can't picture a specific
> change that would actually require a wholesale change to the scheme.

That is the exact reason for having pluggable backend, because we cannot 
determine now if there will be a need of new scheme in future or not.


>
> You mention new features, support for new authentication mechanisms, and
> addition of new variables.
>
>   - New features is a bit too generic to answer specifically. In general
>     I accept that there exists some new feature that would be
>     sufficiently backwards-incompatible as to require a new version. I
>     just can't think of one off the top of my head and so I'm not
>     convinced it's worth the complexity. Did you have something in mind?

That is the idea to keep the design flexible to be able to handle future 
additions with maximum reuse. Example, supporting new algorithms or a 
different handling of secure variable updates by different vendors.


>
>   - By support for new authentication mechanisms, I assume you mean new
>     mechanisms for authenticating variable updates? This is communicated
>     in edk2 via the attributes field. Looking at patch 5 from the skiboot
>     series:
>
> + * When the attribute EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS is set,
> + * then the Data buffer shall begin with an instance of a complete (and
> + * serialized) EFI_VARIABLE_AUTHENTICATION_2 descriptor.
>
>     Could a new authentication scheme be communicated by setting a
>     different attribute value? Or are we not carrying attributes in the
>     metadata blob?
>
>   - For addition of new variables, I'm confused as to why this would
>     require a new API - wouldn't it just be exposed in the normal way via
>     opal_secvar_get(_next)?

Sorry, probably it wasn't clear. By addition of new variables, we meant 
that over time we might have to add new "volatile" variables that "fine 
tunes" secure boot state. This might impact the kernel if it needs to 
understand new variables to define its policies. However, this will not 
result in change of API, it will result in change of the version.


>
> I guess I also somewhat object to calling it a 'backend' if we're using
> it as a version scheme. I think the skiboot storage backends are true
> backends - they provide different implementations of the same
> functionality with the same API, but this seems like you're using it to
> indicate different functionality. It seems like we're using it as if it
> were called OPAL_SECVAR_VERSION.

We are changing how we are exposing the version to the kernel. The 
version will be exposed as device-tree entry rather than a OPAL runtime 
service. We are not tied to the name "backend", we can switch to calling 
it as "scheme" unless there is a better name.

Thanks & Regards,
       - Nayna

