Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1BD6F90A6
	for <lists+linux-efi@lfdr.de>; Sat,  6 May 2023 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjEFIsz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 May 2023 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFIsx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 May 2023 04:48:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A9A55B4;
        Sat,  6 May 2023 01:48:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso2464300a91.2;
        Sat, 06 May 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683362926; x=1685954926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5gp/ysC7RzHTwC0QyDSAw0690/l3V+xrH4kPsGBfCA=;
        b=lTUO84RZmEWG23enJeiW8AvCWoWBsaNcXxzAcm6IW2GsrdyueD5k4h0jCbFtSh4bop
         1D5AUeJU1h0uoLRQTQqSuF+7vw7QapLOeZnwuMlIv9n3oXy9xqY5zNbYrzbdcLhzjLjN
         GWyJg4Rw6bkYdowYxtH6BY3PQKgVkEQyle+RlPcIc1DFiMNrVC/1HWQWVo7F4n4xwSxW
         MrnutfI/VjwhzqJYLy6cnbtCfZedBS1Pq3WbRjyldQ2c1AVB+SKmx4SoB+l0LQZg4/ej
         KREOGsCm81iflseZyL90ToBy2VsLBf3DUUh6ma2s6QiJfx31G4R1OO1X0q7MU7wOpq58
         AVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683362926; x=1685954926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5gp/ysC7RzHTwC0QyDSAw0690/l3V+xrH4kPsGBfCA=;
        b=jum6X1IYWyoZiRyAKf+oIIlZ3BDs6//vvisoVIDM9o10tlK6ZlQexH/ZoQzl3o3AG+
         y0v1aSpMVWR08nlfYACzjE0jnLrVrIevEajA3uzuO0FwyyH0yTHU/18zLlcegOdNhfqz
         i98bVTtvs06RvrMcD0Gyx7UzWep2mzxBjDljnABHcv0rMCmKyuODs4UWKHEFNzCwrls4
         sCu2rh4Ow1ALPplKhKwvXYEx/SuZHtc2LDF/1EiiBU+kUsXiVEhJRSnI0td3DcvTsFCc
         rgonqJ+gRYkm88VdXlbqK061cokC/6TkKnySsg2fHNRWH1gKQ5UoqMVi1Ezboeh5yz2i
         UxIw==
X-Gm-Message-State: AC+VfDwXfa1aD3UuAnwZ10vCFAKoVPWRa09TRtvxRJjBecHDKkhNA/b8
        7qIrjI94kkgA9XYXP9eTEpQ=
X-Google-Smtp-Source: ACHHUZ7b/CRpIZk2j5zGZtm15dGF5qHcSG2+M+Q7BEYmhcPMYprBQtwXhOOXNH/Wt0h3z1aIx4QMsA==
X-Received: by 2002:a17:90b:8c2:b0:24e:1f14:991e with SMTP id ds2-20020a17090b08c200b0024e1f14991emr4081386pjb.36.1683362925595;
        Sat, 06 May 2023 01:48:45 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id bp12-20020a17090b0c0c00b0024dfcaed451sm6221999pjb.52.2023.05.06.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 01:48:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 55654106287; Sat,  6 May 2023 15:48:42 +0700 (WIB)
Date:   Sat, 6 May 2023 15:48:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <ZFYUaQ0KYJhkv2Y0@debian.me>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFj0uPPLs2EhJ1Uk"
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--OFj0uPPLs2EhJ1Uk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +System Launch Integrity documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::

By convention, doc toctree have 2-level depth (only page title and
first-level headings are visible). You may consider adding
`:maxdepth: 2` option.

> diff --git a/Documentation/security/launch-integrity/principles.rst b/Doc=
umentation/security/launch-integrity/principles.rst
> new file mode 100644
> index 0000000..73cf063
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/principles.rst
> @@ -0,0 +1,313 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +System Launch Integrity
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document serves to establish a common understanding of what is syst=
em
> +launch, the integrity concern for system launch, and why using a Root of=
 Trust
> +(RoT) from a Dynamic Launch may be desired. Through out this document
> +terminology from the Trusted Computing Group (TCG) and National Institue=
 for
> +Science and Technology (NIST) is used to ensure a vendor nutrual languag=
e is
> +used to describe and reference security-related concepts.
> +
> +System Launch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There is a tendency to only consider the classical power-on boot as the =
only
> +means to launch an Operating System (OS) on a computer system, but in fa=
ct most
> +modern processors support two methods to launch the system. To provide c=
larity a
> +common definition of a system launch should be established. This definit=
ion is
> +that a during a single power life cycle of a system, a System Launch con=
sists
> +of an initialization event, typically in hardware, that is followed by an
> +executing software payload that takes the system from the initialized st=
ate to
> +a running state. Driven by the Trusted Computing Group (TCG) architectur=
e,
> +modern processors are able to support two methods to launch a system, th=
ese two
> +types of system launch are known as Static Launch and Dynamic Launch.
> +
> +Static Launch
> +-------------
> +
> +Static launch is the system launch associated with the power cycle of th=
e CPU.
> +Thus static launch refers to the classical power-on boot where the
> +initialization event is the release of the CPU from reset and the system
> +firmware is the software payload that brings the system up to a running =
state.
> +Since static launch is the system launch associated with the beginning o=
f the
> +power lifecycle of a system, it is therefore a fixed, one-time system la=
unch.
> +It is because of this that static launch is referred to and thought of a=
s being
> +"static".
> +
> +Dynamic Launch
> +--------------
> +
> +Modern CPUs architectures provides a mechanism to re-initialize the syst=
em to a
> +"known good" state without requiring a power event. This re-initializati=
on
> +event is the event for a dynamic launch and is referred to as the Dynamic
> +Launch Event (DLE). The DLE functions by accepting a software payload, r=
eferred
> +to as the Dynamic Configuration Environment (DCE), that execution is han=
ded to
> +after the DLE is invoked. The DCE is responsible for bringing the system=
 back
> +to a running state. Since the dynamic launch is not tied to a power even=
t like
> +the static launch, this enables a dynamic launch to be initiated at any =
time
> +and multiple times during a single power life cycle. This dynamism is the
> +reasoning behind referring to this system launch as being dynamic.
> +
> +Because a dynamic launch can be conducted at any time during a single po=
wer
> +life cycle, they are classified into one of two types, an early launch o=
r a
> +late launch.
> +
> +:Early Launch: When a dynamic launch is used as a transition from a stat=
ic
> +   launch chain to the final Operating System.
> +
> +:Late Launch: The usage of a dynamic launch by an executing Operating Sy=
stem to
> +   transition to a =E2=80=9Cknown good=E2=80=9D state to perform one or =
more operations, e.g. to
> +   launch into a new Operating System.
> +
> +System Integrity
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A computer system can be considered a collection of mechanisms that work
> +together to produce a result. The assurance that the mechanisms are func=
tioning
> +correctly and producing the expected result is the integrity of the syst=
em. To
> +ensure a system's integrity there are a subset of these mechanisms, comm=
only
> +referred to as security mechanisms, that are present to help ensure the =
system
> +produces the expected result or at least detect the potential of an unex=
pected
> +result may have happened. Since the security mechanisms are relied upon =
to
> +ensue the integrity of the system, these mechanisms are trusted. Upon
> +inspection these security mechanisms each have a set of properties and t=
hese
> +properties can be evaluated to determine how susceptible a mechanism mig=
ht be
> +to failure. This assessment is referred to as the Strength of Mechanism =
and for
> +trusted mechanism enables for the trustworthiness of that mechanism to be
> +quantified.
> +
> +For software systems there are two system states for which the integrity=
 is
> +critical, when the software is loaded into memory and when the software =
is
> +executing on the hardware. Ensuring that the expected software is load i=
nto
> +memory is referred to as load-time integrity while ensuring that the sof=
tware
> +executing is the expected software is the runtime integrity of that soft=
ware.
> +
> +Load-time Integrity
> +-------------------
> +
> +It is critical to understand what load-time integrity establishes about a
> +system and what is assumed, i.e. what is being trusted. Load-time integr=
ity is
> +when a trusted entity, i.e. an entity with an assumed integrity, takes an
> +action to assess an entity being loaded into memory before it is used. A
> +variety of mechanisms may be used to conduct the assessment, each with
> +different properties. A particular property is whether the mechanism cre=
ates an
> +evidence of the assessment. Often either cryptographic signature checkin=
g or
> +hashing are the common assessment operations used.
> +
> +A signature checking assessment functions by requiring a representation =
of the
> +accepted authorities and uses those representations to assess if the ent=
ity has
> +been signed by an accepted authority. The benefit to this process is that
> +assessment process includes an adjudication of the assessment. The drawb=
acks
> +are that 1) the adjudication is susceptible to tampering by the Trusted
> +Computing Base (TCB), 2) there is no evidence to assert that an untamper=
ed
> +adjudication was completed, and 3) the system must be an active particip=
ant in
> +the key management infrastructure.
> +
> +A cryptographic hashing assessment does not adjudicate the assessment but
> +instead generates evidence of the assessment to be adjudicated independe=
ntly.
> +The benefits to this approach is that the assessment may be simple such =
that it
> +is able to be implemented as an immutable mechanism, e.g. in hardware.
> +Additionally it is possible for the adjudication to be conducted where it
> +cannot be tampered with by the TCB. The drawback is that a compromised
> +environment will be allowed to execute until an adjudication can be comp=
leted.
> +
> +Ultimately load-time integrity provides confidence that the correct enti=
ty was
> +loaded and in the absence of a run-time integrity mechanism assumes, i.e
> +trusts, that the entity will never become corrupted.
> +
> +Runtime Integrity
> +-----------------
> +
> +Runtime integrity in the general sense is when a trusted entity makes an
> +assessment of an entity at any point in time during the assessed entity's
> +execution. A more concrete explanation is the taking of an integrity ass=
essment
> +of an active process executing on the system at any point during the pro=
cess'
> +execution. Often the load-time integrity of an operating system's user-s=
pace,
> +i.e. the operating environment, is confused to be the runtime integrity =
of the
> +system since it is an integrity assessment of the "runtime" software. The
> +reality is that actual runtime integrity is a very difficult problem and=
 thus
> +not very many solutions are public and/or available. One example of a ru=
ntime
> +integrity solution would be John Hopkins Advanced Physics Labratory's (A=
PL)
> +Linux Kernel Integrity Module (LKIM).
> +
> +Trust Chains
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Bulding upon the understanding of security mechanisms to establish load-=
time
> +integrity of an entity, it is possible to chain together load-time integ=
rity
> +assessments to establish the integrity of the whole system. This process=
 is
> +known as transitive trust and provides the concept of building a chain of
> +load-time integrity assessments, commonly referred to as a trust chain. =
These
> +assessments may be used to adjudicate the load-time integrity of the who=
le
> +system. This trust chain is started by a trusted entity that does the fi=
rst
> +assessment. This first entity is referred to as the Root of Trust(RoT) w=
ith the
> +entities name being derived from the mechanism used for the assessment, =
i.e.
> +RoT for Verification (RTV) and RoT for Measurement (RTM).
> +
> +A trust chain is itself a mechanism, specifically a mechanism of mechani=
sms,
> +and therefore it too has a Strength of Mechanism. The factors that contr=
ibute
> +to a trust chain's strength are,
> +
> +  - The strength of the chain's RoT
> +  - The strength of each member of the trust chain
> +  - The length, i.e. the number of members, of the chain
> +
> +Therefore to provide the strongest trust chains, they should start with a
> +strong RoT and should consist of members being of low complexity and min=
imizing
> +the number of members participating as is possible. In a more colloquial=
 sense,
> +a trust chain is only as strong as it weakests link and more links incre=
ase
> +the probability of a weak link.
> +
> +Dynamic Launch Components
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The TCG architecture for dynamic launch is composed of a component serie=
s that
> +are used to setup and then carry out the launch. These components work t=
ogether
> +to construct a RTM trust chain that is rooted in the dynamic launch and =
thus
> +commonly referred to as the Dynamic Root of Trust for Measurement (DRTM)=
 chain.
> +
> +What follows is a brief explanation of each component in execution order=
=2E A
> +subset of these components are what establishes the dynamic launch's tru=
st
> +chain.
> +
> +Dynamic Configuration Environment Preamble
> +------------------------------------------
> +
> +The Dynamic Configuration Environment (DCE) Preamble is responsible for =
setting
> +up the system environment in preparation for a dynamic launch. The DCE P=
reamble
> +is not a part of the DRTM trust chain.
> +
> +Dynamic Launch Event
> +--------------------
> +
> +The dynamic launch event is the event, typically a CPU instruction, that=
 triggers
> +the system's dynamic launch mechanism to begin the launch. The dynamic l=
aunch
> +mechanism is also the RoT for the DRTM trust chain.
> +
> +Dynamic Configuration Environment
> +---------------------------------
> +
> +The dynamic launch mechanism may have resulted in a reset of a portion o=
f the
> +system. To bring the system back to an adequate state for system softwar=
e the
> +dynamic launch will hand over control to the DCE. Prior to handing over =
this
> +control, the dynamic launch will measure the DCE. Once the DCE is comple=
te it
> +will proceed to measure and then execute the Dynamic Launch Measured
> +Environment (DLME).
> +
> +Dynamic Launch Measured Environment
> +-----------------------------------
> +
> +The DLME is the first system kernel to have control of the system but ma=
y not
> +be the last. Depending on the usage and configuration, the DLME may be t=
he
> +final/target operating system or it may be a boot loader that will load =
the
> +final/target operating system.
> +
> +Why DRTM
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +It is a fact that DRTM increases the load-time integrity of the system by
> +providing a trust chain that has an immutable hardware RoT, uses a limit=
ed
> +number of small, special purpose code to establish the trust chain that =
starts
> +the target operating system. As mentioned in the Trust Chain section, th=
ese are
> +the main three factors in driving up the strength of a trust chain. As c=
an been
> +seen by the BootHole exploit, which in fact did not effect the integrity=
 of
> +DRTM solutions, the sophistication of attacks targeting system launch is=
 at an
> +all time high. There is no reason a system should not employ every integ=
rity
> +measure hardware makes available. This is the crux of a defense-in-depth
> +approach to system security. In the past the now closed SMI gap was often
> +pointed to as invalidating DRTM, which in fact was nothing but a strawman
> +argument. As has continued to be demonstrated, if/when SMM is corrupted =
it can
> +always circumvent all load-time integrity, SRTM and DRTM, because it is a
> +run-time integrity problem. Regardless, Intel and AMD have both deployed
> +runtime integrity for SMI and SMM which is tied directly to DRTM such th=
at this
> +perceived deficiency is now non-existent and the world is moving forward=
 with
> +an expectation that DRTM must be present.
> +
> +Glossary
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. glossary::
> +  integrity
> +    Guarding against improper information modification or destruction, a=
nd
> +    includes ensuring information non-repudiation and authenticity.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instruct=
ions.cfm
> +
> +  mechanism
> +    A process or system that is used to produce a particular result.
> +
> +    - NIST Special Publication 800-160 (VOLUME 1 ) - https://nvlpubs.nis=
t.gov/nistpubs/SpecialPublications/NIST.SP.800-160v1.pdf
> +
> +  risk
> +    A measure of the extent to which an entity is threatened by a potent=
ial
> +    circumstance or event, and typically a function of: (i) the adverse =
impacts
> +    that would arise if the circumstance or event occurs; and (ii) the
> +    likelihood of occurrence.
> +
> +    - NIST SP 800-30 Rev. 1 - https://nvlpubs.nist.gov/nistpubs/Legacy/S=
P/nistspecialpublication800-30r1.pdf
> +
> +  security mechanism
> +    A device or function designed to provide one or more security servic=
es
> +    usually rated in terms of strength of service and assurance of the d=
esign.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instruct=
ions.cfm
> +
> +  Strength of Mechanism
> +    A scale for measuring the relative strength of a security mechanism
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instruct=
ions.cfm
> +
> +  transitive trust
> +    Also known as "Inductive Trust", in this process a Root of Trust giv=
es a
> +    trustworthy description of a second group of functions. Based on this
> +    description, an interested entity can determine the trust it is to p=
lace in
> +    this second group of functions. If the interested entity determines =
that
> +    the trust level of the second group of functions is acceptable, the =
trust
> +    boundary is extended from the Root of Trust to include the second gr=
oup of
> +    functions. In this case, the process can be iterated. The second gro=
up of
> +    functions can give a trustworthy description of the third group of
> +    functions, etc. Transitive trust is used to provide a trustworthy
> +    description of platform characteristics, and also to prove that
> +    non-migratable keys are non-migratable
> +
> +    - TCG Glossary - https://trustedcomputinggroup.org/wp-content/upload=
s/TCG-Glossary-V1.1-Rev-1.0.pdf
> +
> +  trust
> +    The confidence one element has in another that the second element wi=
ll
> +    behave as expected`
> +
> +    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8=
320A.pdf
> +
> +  trust anchor
> +    An authoritative entity for which trust is assumed.
> +
> +    - NIST SP 800-57 Part 1 Rev. 5 - https://nvlpubs.nist.gov/nistpubs/S=
pecialPublications/NIST.SP.800-57pt1r5.pdf
> +
> +  trusted
> +    An element that another element relies upon to fulfill critical
> +    requirements on its behalf.
> +
> +    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8=
320A.pdf
> +
> +  trusted computing base (TCB)
> +    Totality of protection mechanisms within a computer system, including
> +    hardware, firmware, and software, the combination responsible for en=
forcing
> +    a security policy.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instruct=
ions.cfm
> +
> +  trusted computer system
> +    A system that has the necessary security functions and assurance tha=
t the
> +    security policy will be enforced and that can process a range of
> +    information sensitivities (i.e. classified, controlled unclassified
> +    information (CUI), or unclassified public information) simultaneousl=
y.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instruct=
ions.cfm
> +
> +  trustworthiness
> +    The attribute of a person or enterprise that provides confidence to =
others
> +    of the qualifications, capabilities, and reliability of that entity =
to
> +    perform specific tasks and fulfill assigned responsibilities.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instruct=
ions.cfm
> diff --git a/Documentation/security/launch-integrity/secure_launch_detail=
s.rst b/Documentation/security/launch-integrity/secure_launch_details.rst
> new file mode 100644
> index 0000000..2e71543
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/secure_launch_details.rst
> @@ -0,0 +1,564 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Secure Launch Config and Interfaces
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The settings to enable Secure Launch using Kconfig are under::
> +
> +  "Processor type and features" --> "Secure Launch support"
> +
> +A kernel with this option enabled can still be booted using other suppor=
ted
> +methods.
> +
> +To reduce the Trusted Computing Base (TCB) of the MLE [1]_, the build
> +configuration should be pared down as narrowly as one's use case allows.
> +The fewer drivers (less active hardware) and features reduces the attack
> +surface. E.g. in the extreme, the MLE could only have local disk access
> +and no other hardware support. Or only network access for remote attesta=
tion.
> +
> +It is also desirable if possible to embed the initrd used with the MLE k=
ernel
> +image to reduce complexity.
> +
> +The following are a few important configuration necessities to always co=
nsider:
> +
> +KASLR Configuration
> +-------------------
> +
> +Secure Launch does not interoperate with KASLR. If possible, the MLE sho=
uld be
> +built with KASLR disabled::
> +
> +  "Processor type and features" -->
> +      "Build a relocatable kernel" -->
> +          "Randomize the address of the kernel image (KASLR) [ ]"
> +
> +This unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
> +
> +If not possible, KASLR must be disabled on the kernel command line when =
doing
> +a Secure Launch as follows::
> +
> +  nokaslr
> +
> +IOMMU Configuration
> +-------------------
> +
> +When doing a Secure Launch, the IOMMU should always be enabled and the d=
rivers
> +loaded. However, IOMMU passthrough mode should never be used. This leave=
s the
> +MLE completely exposed to DMA after the PMR's [2]_ are disabled. The cur=
rent default
> +mode is to use IOMMU in lazy translated mode but strict translated mode =
is the preferred
> +IOMMU mode and this should be selected in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "IOMMU default domain type" -->
> +              "(X) Translated - Strict"
> +
> +In addition, the Intel IOMMU should be on by default. The following sets=
 this as the
> +default in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]"
> +
> +and::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
> +              "Enable Intel DMA Remapping Devices by default  [*]"
> +
> +It is recommended that no other command line options should be set to ov=
erride
> +the defaults above.
> +
> +Secure Launch Resource Table
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard=
 format
> +for providing information for the pre-launch environment and to pass
> +information to the post-launch environment. The table is populated by on=
e or
> +more bootloaders in the boot chain and used by Secure Launch on how to s=
etup
> +the environment during post-launch. The details for the SLRT are documen=
ted
> +in the TrenchBoot Secure Launch Specifcation [3]_.
> +
> +Intel TXT Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The primary interfaces between the various components in TXT are the TXT=
 MMIO
> +registers and the TXT heap. The MMIO register banks are described in App=
endix B
> +of the TXT MLE [1]_ Development Guide.
> +
> +The TXT heap is described in Appendix C of the TXT MLE [1]_ Development
> +Guide. Most of the TXT heap is predefined in the specification. The heap=
 is
> +initialized by firmware and the pre-launch environment and is subsequent=
ly used
> +by the SINIT ACM. One section, called the OS to MLE Data Table, is reser=
ved for
> +software to define. This table is set up per the recommendation detailed=
 in
> +Appendix B of the TrenchBoot Secure Launch Specification::
> +
> +        /*
> +         * Secure Launch defined OS/MLE TXT Heap table
> +         */
> +        struct txt_os_mle_data {
> +                u32 version;
> +                u32 boot_params_addr;
> +                struct slr_table *slrt;
> +                u64 txt_info;
> +                u32 ap_wake_block;
> +                u32 ap_wake_block_size;
> +                u8 mle_scratch[64];
> +        } __packed;
> +
> +Description of structure:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Field                  Use
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +version                Structure version, current value 1
> +boot_params_addr       Physical base address of the Linux boot parameters
> +slrt                   Physical address of the Secure Launch Resource Ta=
ble
> +txt_info               Pointer into the SLRT for easily locating TXT spe=
cific table
> +ap_wake_block          Physical address of the block of memory for parki=
ng APs after a launch
> +ap_wake_block_size     Size of the AP wake block
> +mle_scratch            Scratch area used post-launch by the MLE kernel. =
Fields:
> +=20
> +                        - SL_SCRATCH_AP_EBX area to share %ebx base poin=
ter among CPUs
> +                        - SL_SCRATCH_AP_JMP_OFFSET offset to abs. ljmp f=
ixup location for APs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Error Codes
> +-----------
> +
> +The TXT specification defines the layout for TXT 32 bit error code value=
s.
> +The bit encodings indicate where the error originated (e.g. with the CPU,
> +in the SINIT ACM, in software). The error is written to a sticky TXT
> +register that persists across resets called TXT.ERRORCODE (see the TXT
> +MLE Development Guide). The errors defined by the Secure Launch feature =
are
> +those generated in the MLE software. They have the format::
> +
> +  0xc0008XXX
> +
> +The low 12 bits are free for defining the following Secure Launch specif=
ic
> +error codes.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_GENERIC
> +Value:  0xc0008001
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +Generic catch all error. Currently unused.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_TPM_INIT
> +Value:  0xc0008002
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The Secure Launch code failed to get an access to the TPM hardware inter=
face.
> +This is most likely to due to misconfigured hardware or kernel. Ensure t=
he
> +TPM chip is enabled and the kernel TPM support is built in (it should no=
t be
> +built as a module).
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_TPM_INVALID_LOG20
> +Value:  0xc0008003
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The Secure Launch code failed to find a valid event log descriptor for T=
PM
> +version 2.0 or the event log descriptor is malformed. Usually this indic=
ates
> +that incompatible versions of the pre-launch environment and the MLE ker=
nel.
> +The pre-launch environment and the kernel share a structure in the TXT h=
eap and
> +if this structure (the OS-MLE table) is mismatched, this error is often =
seen.
> +This TXT heap area is setup by the pre-launch environment so the issue m=
ay
> +originate there. It could be the sign of an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_TPM_LOGGING_FAILED
> +Value:  0xc0008004
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +There was a failed attempt to write a TPM event to the event log early i=
n the
> +Secure Launch process. This is likely the result of a malformed TPM even=
t log
> +buffer. Formatting of the event log buffer information is done by the
> +pre-launch environment so the issue most likely originates there.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_REGION_STRADDLE_4GB
> +Value:  0xc0008005
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During early validation a buffer or region was found to straddle the 4GB
> +boundary. Because of the way TXT does DMA memory protection, this is an
> +unsafe configuration and is flagged as an error. This is most likely a
> +configuration issue in the pre-launch environment. It could also be the =
sign of
> +an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Name:   SL_ERROR_TPM_EXTEND
> +Value:  0xc0008006
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Description:
> +
> +There was a failed attempt to extend a TPM PCR in the Secure Launch plat=
form
> +module. This is most likely to due to misconfigured hardware or kernel. =
Ensure
> +the TPM chip is enabled and the kernel TPM support is built in (it shoul=
d not
> +be built as a module).
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_MTRR_INV_VCNT
> +Value:  0xc0008007
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During early Secure Launch validation an invalid variable MTRR count was=
 found.
> +The pre-launch environment passes a number of MSR values to the MLE to r=
estore
> +including the MTRRs. The values are restored by the Secure Launch early =
entry
> +point code. After measuring the values supplied by the pre-launch enviro=
nment,
> +a discrepancy was found validating the values. It could be the sign of an
> +attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_MTRR_INV_DEF_TYPE
> +Value:  0xc0008008
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During early Secure Launch validation an invalid default MTRR type was f=
ound.
> +See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_MTRR_INV_BASE
> +Value:  0xc0008009
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During early Secure Launch validation an invalid variable MTRR base valu=
e was
> +found. See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_MTRR_INV_MASK
> +Value:  0xc000800a
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During early Secure Launch validation an invalid variable MTRR mask valu=
e was
> +found. See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_MSR_INV_MISC_EN
> +Value:  0xc000800b
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During early Secure Launch validation an invalid miscellaneous enable MS=
R value
> +was found. See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_INV_AP_INTERRUPT
> +Value:  0xc000800c
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The application processors (APs) wait to be woken up by the SMP initiali=
zation
> +code. The only interrupt that they expect is an NMI; all other interrupts
> +should be masked. If an AP gets some other interrupt other than an NMI i=
t will
> +cause this error. This error is very unlikely to occur.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_INTEGER_OVERFLOW
> +Value:  0xc000800d
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +A buffer base and size passed to the MLE caused an integer overflow when
> +added together. This is most likely a configuration issue in the pre-lau=
nch
> +environment. It could also be the sign of an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +Name:   SL_ERROR_HEAP_WALK
> +Value:  0xc000800e
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Description:
> +
> +An error occurred in TXT heap walking code. The underlying issue is a fa=
ilure to
> +early_memremap() portions of the heap, most likely due to a resource sho=
rtage.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_HEAP_MAP
> +Value:  0xc000800f
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +This error is essentially the same as SL_ERROR_HEAP_WALK but occurred du=
ring the
> +actual early_memremap() operation.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_REGION_ABOVE_4GB
> +Value:  0xc0008010
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +A memory region used by the MLE is above 4GB. In general this is not a p=
roblem
> +because memory > 4Gb can be protected from DMA. There are certain buffer=
s that
> +should never be above 4Gb though and one of these caused the violation. =
This is
> +most likely a configuration issue in the pre-launch environment. It coul=
d also
> +be the sign of an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_HEAP_INVALID_DMAR
> +Value:  0xc0008011
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The backup copy of the ACPI DMAR table which is supposed to be located i=
n the
> +TXT heap could not be found. This is due to a bug in the platform's ACM =
module
> +or in firmware.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_HEAP_DMAR_SIZE
> +Value:  0xc0008012
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The backup copy of the ACPI DMAR table in the TXT heap is to large to be=
 stored
> +for later usage. This error is very unlikely to occur since the area res=
erved
> +for the copy is far larger than the DMAR should be.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_HEAP_DMAR_MAP
> +Value:  0xc0008013
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The backup copy of the ACPI DMAR table in the TXT heap could not be mapp=
ed. The
> +underlying issue is a failure to early_memremap() the DMAR table, most l=
ikely
> +due to a resource shortage.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Name:   SL_ERROR_HI_PMR_BASE
> +Value:  0xc0008014
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Description:
> +
> +On a system with more than 4G of RAM, the high PMR [2]_ base address sho=
uld be set
> +to 4G. This error is due to that not being the case. This PMR value is s=
et by
> +the pre-launch environment so the issue most likely originates there. It=
 could also
> +be the sign of an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Name:   SL_ERROR_HI_PMR_SIZE
> +Value:  0xc0008015
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Description:
> +
> +On a system with more than 4G of RAM, the high PMR [2]_ size should be s=
et to cover
> +all RAM > 4G. This error is due to that not being the case. This PMR val=
ue is
> +set by the pre-launch environment so the issue most likely originates th=
ere. It
> +could also be the sign of an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Name:   SL_ERROR_LO_PMR_BASE
> +Value:  0xc0008016
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Description:
> +
> +The low PMR [2]_ base should always be set to address zero. This error i=
s due to
> +that not being the case. This PMR value is set by the pre-launch environ=
ment
> +so the issue most likely originates there. It could also be the sign of =
an attempted
> +attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Name:   SL_ERROR_LO_PMR_MLE
> +Value:  0xc0008017
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Description:
> +
> +This error indicates the MLE image is not covered by the low PMR [2]_ ra=
nge. The
> +PMR values are set by the pre-launch environment so the issue most likel=
y originates
> +there. It could also be the sign of an attempted attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_INITRD_TOO_BIG
> +Value:  0xc0008018
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The external initrd provided is larger than 4Gb. This is not a valid
> +configuration for a Secure Launch due to managing DMA protection.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_HEAP_ZERO_OFFSET
> +Value:  0xc0008019
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +During a TXT heap walk an invalid/zero next table offset value was found=
=2E This
> +indicates the TXT heap is malformed. The TXT heap is initialized by the
> +pre-launch environment so the issue most likely originates there. It cou=
ld also
> +be a sign of an attempted attack. In addition, ACM is also responsible f=
or
> +manipulating parts of the TXT heap so the issue could be due to a bug in=
 the
> +platform's ACM module.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_WAKE_BLOCK_TOO_SMALL
> +Value:  0xc000801a
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The AP wake block buffer passed to the MLE via the OS-MLE TXT heap table=
 is not
> +large enough. This value is set by the pre-launch environment so the iss=
ue most
> +likely originates there. It also could be the sign of an attempted attac=
k.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_MLE_BUFFER_OVERLAP
> +Value:  0xc000801b
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +One of the buffers passed to the MLE via the OS-MLE TXT heap table overl=
aps
> +with the MLE image in memory. This value is set by the pre-launch enviro=
nment
> +so the issue most likely originates there. It could also be the sign of =
an attempted
> +attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_BUFFER_BEYOND_PMR
> +Value:  0xc000801c
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +One of the buffers passed to the MLE via the OS-MLE TXT heap table is not
> +protected by a PMR. This value is set by the pre-launch environment so t=
he
> +issue most likey  originates there. It could also be the sign of an atte=
mpted
> +attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_OS_SINIT_BAD_VERSION
> +Value:  0xc000801d
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The version of the OS-SINIT TXT heap table is bad. It must be 6 or great=
er.
> +This value is set by the pre-launch environment so the issue most likely
> +originates there. It could also be the sign of an attempted attack. It i=
s also
> +possible though very unlikely that the platform is so old that the ACM b=
eing
> +used requires an unsupported version.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Name:   SL_ERROR_EVENTLOG_MAP
> +Value:  0xc000801e
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Description:
> +
> +An error occurred in the Secure Launch module while mapping the TPM even=
t log.
> +The underlying issue is memremap() failure, most likely due to a resource
> +shortage.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_TPM_NUMBER_ALGS
> +Value:  0xc000801f
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The TPM 2.0 event log reports an unsupported number of hashing algorithm=
s.
> +Secure launch currently only supports a maximum of two: SHA1 and SHA256.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_TPM_UNKNOWN_DIGEST
> +Value:  0xc0008020
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The TPM 2.0 event log reports an unsupported hashing algorithm. Secure l=
aunch
> +currently only supports two algorithms: SHA1 and SHA256.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_TPM_INVALID_EVENT
> +Value:  0xc0008021
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +An invalid/malformed event was found in the TPM event log while reading =
it.
> +Since only trusted entities are supposed to be writing the event log, th=
is
> +would indicate either a bug or a possible attack.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Name:   SL_ERROR_INVALID_SLRT
> +Value:  0xc0008022
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Description:
> +
> +The Secure Launch Resource Table is invalid or malformed and is unusable.
> +This implies the pre-launch code did not properly setup the SLRT.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_SLRT_MISSING_ENTRY
> +Value:  0xc0008023
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +The Secure Launch Resource Table is missing a required entry within it.
> +This implies the pre-launch code did not properly setup the SLRT.
> +
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name:   SL_ERROR_SLRT_MAP
> +Value:  0xc0008024
> +=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Description:
> +
> +An error occurred in the Secure Launch module while mapping the Secure L=
aunch
> +Resource table. The underlying issue is memremap() failure, most likely =
due to
> +a resource shortage.
> +
> +.. [1]
> +    MLE: Measured Launch Environment is the binary runtime that is measu=
red and
> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describ=
es the
> +    requirements for the MLE in detail.
> +
> +.. [2]
> +    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Re=
gisters.
> +    There are two of these registers and they allow all DMA to be blocked
> +    to large areas of memory. The low PMR can cover all memory below 4Gb=
 on 2Mb
> +    boundaries. The high PMR can cover all RAM on the system, again on 2=
Mb
> +    boundaries. This feature is used during a Secure Launch by TXT.
> +
> +.. [3]
> +    Secure Launch Specification: https://trenchboot.org/specifications/S=
ecure_Launch/
> diff --git a/Documentation/security/launch-integrity/secure_launch_overvi=
ew.rst b/Documentation/security/launch-integrity/secure_launch_overview.rst
> new file mode 100644
> index 0000000..ba91d73
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/secure_launch_overview.rst
> @@ -0,0 +1,220 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Secure Launch Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Prior to the start of the TrenchBoot project, the only active Open Source
> +project supporting dynamic launch was Intel's tboot project to support t=
heir
> +implementation of dynamic launch known as Intel Trusted eXecution Techno=
logy
> +(TXT). The approach taken by tboot was to provide an exokernel that could
> +handle the launch protocol implemented by Intel's special loader, the SI=
NIT
> +Authenticated Code Module (ACM [2]_) and remained in memory to manage th=
e SMX
> +CPU mode that a dynamic launch would put a system. While it is not precl=
uded
> +from being used for doing a late launch, tboot's primary use case was to=
 be
> +used as an early launch solution. As a result the TrenchBoot project sta=
rted
> +the development of Secure Launch kernel feature to provide a more genera=
lized
> +approach. The focus of the effort is twofold, the first is to make the L=
inux
> +kernel directly aware of the launch protocol used by Intel, AMD/Hygon, A=
rm, and
> +potentially OpenPOWER. The second is to make the Linux kernel be able to
> +initiate a dynamic launch. It is through this approach that the Secure L=
aunch
> +kernel feature creates a basis for the Linux kernel to be used in a vari=
ety of
> +dynamic launch use cases.
> +
> +.. note::
> +    A quick note on terminology. The larger open source project itself is
> +    called TrenchBoot, which is hosted on GitHub (links below). The kern=
el
> +    feature enabling the use of the x86 technology is referred to as "Se=
cure
> +    Launch" within the kernel code.
> +
> +Goals
> +=3D=3D=3D=3D=3D
> +
> +The first use case that the TrenchBoot project focused on was the abilit=
y for
> +the Linux kernel to be started by a dynamic launch, in particular as par=
t of an
> +early launch sequence. In this case the dynamic launch will be initiated=
 by any
> +boot loader with associated support added to it, for example the first t=
argeted
> +boot loader in this case was GRUB2. An integral part of establishing a
> +measurement-based launch integrity involves measuring everything that is
> +intended to be executed (kernel image, initrd, etc) and everything that =
will
> +configure that kernel to execute (command line, boot params, etc). Then =
storing
> +those measurements in a protected manner. Both the Intel and AMD dynamic=
 launch
> +implementations leverage the Trusted Platform Module (TPM) to store those
> +measurements. The TPM itself has been designed such that a dynamic launch
> +unlocks a specific set of Platform Configuration Registers (PCR) for hol=
ding
> +measurement taken during the dynamic launch.  These are referred to as t=
he DRTM
> +PCRs, PCRs 17-22. Further details on this process can be found in the
> +documentation for the GETSEC instruction provided by Intel's TXT and the=
 SKINIT
> +instruction provided by AMD's AMD-V. The documentation on these technolo=
gies
> +can be readily found online; see the `Resources`_ section below for refe=
rences.
> +
> +.. note::
> +    Currently only Intel TXT is supported in this first release of the S=
ecure
> +    Launch feature. AMD/Hygon SKINIT and Arm support will be added in a
> +    subsequent release.
> +
> +To enable the kernel to be launched by GETSEC a stub, the Secure Launch =
stub,
> +must be built into the setup section of the compressed kernel to handle =
the
> +specific state that the dynamic launch process leaves the BSP. Also the =
Secure
> +Launch stub must measure everything that is going to be used as early as
> +possible. This stub code and subsequent code must also deal with the spe=
cific
> +state that the dynamic launch leaves the APs as well.
> +
> +Design Decisions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A number of design decisions were made during the development of the Sec=
ure
> +Launch feature. The two primary guiding decisions were:
> +
> + - Keeping the Secure Launch code as separate from the rest of the kernel
> +   as possible.
> + - Modifying the existing boot path of the kernel as little as possible.
> +
> +The following illustrate how the implementation followed these design
> +decisions:
> +
> + - All the entry point code necessary to properly configure the system p=
ost
> +   launch is found in st_stub.S in the compressed kernel image. This code
> +   validates the state of the system, restores necessary system operating
> +   configurations and properly handles post launch CPU states.
> + - After the sl_stub.S is complete, it jumps directly to the unmodified
> +   startup_32 kernel entry point.
> + - A single call is made to a function sl_main() prior to the main kernel
> +   decompression step. This code performs further validation and takes t=
he
> +   needed DRTM measurements.
> + - After the call to sl_main(), the main kernel is decompressed and boot=
s as
> +   it normally would.
> + - Final setup for the Secure Launch kernel is done in a separate Secure
> +   Launch module that is loaded via a late initcall. This code is respon=
sible
> +   for extending the measurements taken earlier into the TPM DRTM PCRs a=
nd
> +   setting up the securityfs interface to allow access the TPM event log=
 and
> +   public TXT registers.
> + - On the reboot and kexec paths, calls are made to a function to finali=
ze the
> +   state of the Secure Launch kernel.
> +
> +The one place where Secure Launch code is mixed directly in with kernel =
code is
> +in the SMP boot code. This is due to the unique state that the dynamic l=
aunch
> +leaves the APs in. On Intel this involves using a method other than the
> +standard INIT-SIPI sequence.
> +
> +A final note is that originally the extending of the PCRs was completed =
in the
> +Secure Launch stub when the measurements were taken. An alternative solu=
tion
> +had to be implemented due to the TPM maintainers objecting to the PCR
> +extensions being done with a minimal interface to the TPM that was an
> +independent implementation of the mainline kernel driver. Since the main=
line
> +driver relies heavily on kernel interfaces not available in the compress=
ed
> +kernel, it was not possible to reuse the mainline TPM driver. This resul=
ted in
> +the decision to move the extension operations to the Secure Launch modul=
e in
> +the mainline kernel where the TPM driver would be available.
> +
> +Basic Boot Flow
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Outlined here is summary of the boot flow for Secure Launch. A more deta=
iled
> +review of Secure Launch process can be found in the Secure Launch
> +Specification, a link is located in the `Resources`_ section.
> +
> +Pre-launch: *Phase where the environment is prepared and configured to i=
nitiate the
> +secure launch by the boot chain.*
> +
> + - The SLRT is initialized and dl_stub is placed in memory.
> + - Load the kernel, initrd and ACM [2]_ into memory.
> + - Setup the TXT heap and page tables describing the MLE [1]_ per the
> +   specification.
> + - If non-UEFI platform, dl_stub is called.
> + - If UEFI platforms, SLRT registered with UEFI and efi-stub called.
> + - Upon completion, efi-stub will call EBS followed by dl_stub.
> + - The dl_stub will prepare the CPU and the TPM for the launch.
> + - The secure launch is then initiated with the GETSET[SENTER] instructi=
on.
> +
> +Post-launch: *Phase where control is passed from the ACM to the MLE and =
the secure
> +kernel begins execution.*
> +
> + - Entry from the dynamic launch jumps to the SL stub.
> + - SL stub fixes up the world on the BSP.
> + - For TXT, SL stub wakes the APs, fixes up their worlds.
> + - For TXT, APs are left halted waiting for an NMI to wake them.
> + - SL stub jumps to startup_32.
> + - SL main does validation of buffers and memory locations. It sets
> +   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
> +   kernel that a Secure Launch was done.
> + - SL main locates the TPM event log and writes the measurements of
> +   configuration and module information into it.
> + - Kernel boot proceeds normally from this point.
> + - During early setup, slaunch_setup() runs to finish some validation
> +   and setup tasks.
> + - The SMP bring up code is modified to wake the waiting APs. APs vector
> +   to rmpiggy and start up normally from that point.
> + - SL platform module is registered as a late initcall module. It reads
> +   the TPM event log and extends the measurements taken into the TPM PCR=
s.
> + - SL platform module initializes the securityfs interface to allow
> +   access to the TPM event log and TXT public registers.
> + - Kernel boot finishes booting normally
> + - SEXIT support to leave SMX mode is present on the kexec path and
> +   the various reboot paths (poweroff, reset, halt).
> +
> +PCR Usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The TCG DRTM architecture there are three PCRs defined for usage, PCR.De=
tails
> +(PCR17), PCR.Authorities (PCR18), and PCR.DLME_Authority (PCR19). For a =
deeper
> +understanding of Detail and Authorities it is recommended to review the =
TCG
> +DRTM architecture.
> +
> +To determine PCR usage, Linux Secure Launch follows the TrenchBoot Secure
> +Launch Specification of using a measurement policy stored in the SLRT. T=
he
> +policy details what should be measured and the PCR in which to store the
> +measurement. The measurement policy provides the ability to select the
> +PCR.DLME_Detail (PCR20) PCR as the location for the DRTM components meas=
ured by
> +the kernel, e.g. external initrd image. This can then be combined with s=
toring
> +the user authority in the PCR.DLME_Authority=C2=A0PCR to seal/attest to =
different
> +variations of platform details/authorities and user details/authorities.=
 An
> +example of how this can be achieved was presented in the FOSDEM - 2021 t=
alk
> +"Secure Upgrades with DRTM".
> +
> +Resources
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The TrenchBoot project:
> +
> +https://trenchboot.org
> +
> +Secure Launch Specification:
> +
> +https://trenchboot.org/specifications/Secure_Launch/
> +
> +Trusted Computing Group's D-RTM Architecture:
> +
> +https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architect=
ure_v1-0_Published_06172013.pdf
> +
> +TXT documentation in the Intel TXT MLE Development Guide:
> +
> +https://www.intel.com/content/dam/www/public/us/en/documents/guides/inte=
l-txt-software-development-guide.pdf
> +
> +TXT instructions documentation in the Intel SDM Instruction Set volume:
> +
> +https://software.intel.com/en-us/articles/intel-sdm
> +
> +AMD SKINIT documentation in the System Programming manual:
> +
> +https://www.amd.com/system/files/TechDocs/24593.pdf
> +
> +GRUB Secure Launch support:
> +
> +https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub
> +
> +FOSDEM 2021: Secure Upgrades with DRTM
> +
> +https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
> +
> +.. [1]
> +    MLE: Measured Launch Environment is the binary runtime that is measu=
red and
> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describ=
es the
> +    requirements for the MLE in detail.
> +
> +.. [2]
> +    ACM: Intel's Authenticated Code Module. This is the 32b bit binary b=
lob that
> +    is run securely by the GETSEC[SENTER] during a measured launch. It i=
s described
> +    in the Intel documentation on TXT and versions for various chipsets =
are
> +    signed and distributed by Intel.
=20
The formatting LGTM, thanks!

Regardless,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--OFj0uPPLs2EhJ1Uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFYUZgAKCRD2uYlJVVFO
o3jYAP9JuwKGv6HdxuiH4VejiT5m/CCnjrCUo33YTxJV3e/UbwEAogJ/Jerkhz1Y
2Vl4Pyb61o+ixaqlxk2GuMmAzEcawAQ=
=TjwB
-----END PGP SIGNATURE-----

--OFj0uPPLs2EhJ1Uk--
